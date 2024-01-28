#reloadable
#priority 1000000009
import crafttweaker.util.Math;
import crafttweaker.data.IData;
import scripts.advanced.libs.Data;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IVector3d;
import crafttweaker.entity.IEntity;
import crafttweaker.world.IWorld;


// Vectors are represented by double[] with length 3
// All trigonometric functions use degree
static PIE as double = 3.1415927;
//Int
function floor(x as double)as int{
    return Math.floor(x)as int;
}
// Fast trigonometric
static sinfans as double[]=[]as double[];
for i in 0 to 900{
    sinfans+=Math.sin(PIE*0.1*i/180);
}
function getsinfans(x1 as int)as double{
    var x=(x1%3600+3600)%3600;
    if(x==900)return 1.0;
    if(x<900)return sinfans[x];
    if(x<1800)return getsinfans(1800-x);
    return -getsinfans(x- 1800);
}
function sinf(x as double)as double{
    var a as int=Math.floor(x*10)as int;
    return getsinfans(a)*(1.0+a-x*10)+getsinfans(a+1)*(x*10-a);
}
function cosf(x as double)as double{
    return sinf(x+90);
}
function tanf(x as double)as double{
    if(cosf(x)==0.0)return 0.0;
    return sinf(x)/cosf(x);
}
function sinfR(x as double)as double{
    return sinf(x*PIE/180);
}
function cosfR(x as double)as double{
    return cosf(x*PIE/180);
}
function tanfR(x as double)as double{
    return tanf(x*PIE/180);
}
static asinfans as double[]=[] as double[];
for i in 0 to 1010{
    asinfans+=Math.asin(0.001*i)/PIE*180;
}
function asinf(x1 as double)as double{
    if(x1==0)return 0.0;
    if(x1==1)return PIE/2;
    if(x1<0)return -asinf(-x1);
    var I = x1*1000;
    var L = 0+I;
    //print(L);
    return asinfans[L]*(L+1-I)+asinfans[L+1]*(I-L);
}
function sin(x as double)as double{return sinf(x);}
function cos(x as double)as double{return cosf(x);}
function tan(x as double)as double{return tanf(x);}
function cot(x as double)as double{return (cosf(x)==0)?0.0:(1.0/tanf(x));}
function sec(x as double)as double{return 1.0/cosf(x);}
function cosec(x as double)as double{return 1.0/sinf(x);}
function asin(x as double)as double{return asinf(x);}
function acos(x as double)as double{return 90.0-asin(x);}
function atan(x as double)as double{return Math.atan(x)/PIE*180.0;}
function atan2(y as double, x as double)as double{
    var t = atan(y/x);
    return (x<0) ? (t+180) :t;
}

function sinR(x as double)as double{return sinfR(x);}
function cosR(x as double)as double{return cosfR(x);}
function tanR(x as double)as double{return tanfR(x);}
function cotR(x as double)as double{return (cosfR(x)==0)?0.0:(1.0/tanfR(x));}
function secR(x as double)as double{return 1.0/cosfR(x);}
function cosecR(x as double)as double{return 1.0/sinfR(x);}
function asinR(x as double)as double{return asinf(x)/180*PIE;}
function acosR(x as double)as double{return PIE-asinR(x);}
function atanR(x as double)as double{return Math.atan(x);}
function atan2R(y as double, x as double)as double{
    var t = atanR(y/x);
    return (x<0) ? (t+PIE) : t;
}

function sqrt(x as double)as double{
    return Math.sqrt(x);
}


//Random Number
function randDoubleRaw(world as IWorld)as double{
    return world.random.nextDouble();
}
function randDouble(max as double, min as double, world as IWorld)as double{
    return randDoubleRaw(world)*(max-min)+min;
}
function randInt(max as int, min as int, world as IWorld)as int{
    return Math.floor(randDouble(0.99999+max, 0.0+min, world))as int;
}
function randBool(world as IWorld)as bool{
    return randInt(1,0,world)>0;
}

// Constant Vectors
static V000 as double[]  =[0.0,0.0,0.0]as double[];
static VX as double[]    =[1.0,0.0,0.0]as double[];
static VY as double[]    =[0.0,1.0,0.0]as double[];
static VZ as double[]    =[0.0,0.0,1.0]as double[];

// Basic Data Operations
function isVector3D(x as double[])as bool{
    return !isNull(x)&&x.length==3;
}
function copy(x as double[])as double[]{
    if(isVector3D(x))return [x[0],x[1],x[2]];
    return [0.0,0.0,0.0];
}
function isZero(x as double[])as bool{
    if(!isVector3D(x))return true;
    return (x[0]==0)&&(x[1]==0)&&(x[2]==0);
}

//Convertion: Data
function readFromData(data as IData, keyPrefix as string="", cap as bool=false, suffix as string="")as double[]{
    var keys as string[]= cap?["X","Y","Z"]:["x","y","z"];
    var t = copy(V000);
    for i in 0 to 3{
        var d = Data.get(data, keyPrefix~keys[i]~suffix);
        if(!isNull(d)){
            t[i]=d.asDouble();
        }
    }
    return t;
}
function asData(pos as double[], keyPrefix as string="", cap as bool=false, suffix as string="")as IData{
    if(!isVector3D(pos))return {};
    var keys as string[]= cap?["X","Y","Z"]:["x","y","z"];
    var d = IData.createEmptyMutableDataMap();
    for i in 0 to 3{
        d=d.deepSet((pos[i])as IData,keyPrefix~keys[i]~suffix);
    }
    //print(d);
    return d;
}
function getPos(entity as IEntity)as double[]{
    if(isNull(entity))return copy(V000);
    return [entity.x, entity.y, entity.z]as double[];
}
//Convertion: BlockPos
function fromBlockPos(pos as IBlockPos, shift as bool = true) as double[]{
    if(shift)   return [0.5+pos.x, 0.5+pos.y, 0.5+pos.z] as double[];
    else        return [0.0+pos.x, 0.0+pos.y, 0.0+pos.z] as double[];
}
function asBlockPos(pos as double[])as IBlockPos{
    if(!isVector3D(pos))return asBlockPos(V000);
    return IBlockPos.create(
        Math.floor(pos[0]),
        Math.floor(pos[1]),
        Math.floor(pos[2])
    );
}
function fromIBlockPos(pos as IBlockPos, shift as bool = true) as double[]{
    return fromBlockPos(pos,shift);
}
function asIBlockPos(pos as double[])as IBlockPos{
    return asBlockPos(pos);
}
//Conversion: IVector3d
function fromIVector3d(v as IVector3d)as double[]{
    return [v.x,v.y,v.z]as double[];
}
function fromIVector3D(v as IVector3d)as double[]{
    return [v.x,v.y,v.z]as double[];
}
function asIVector3d(v as double[])as IVector3d{
    if(!isVector3D(v))return asIVector3d(V000);
    return IVector3d.create(v[0],v[1],v[2]);
}
function asIVector3D(v as double[])as IVector3d{
    return asIVector3d(v);
}
//Convertion: toString
function asString(x as double[], char as string=" ")as string{
    if(!isVector3D(x))return "invalid vector";
    return x[0]~char~x[1]~char~x[2];
}
function display(x as double[])as string{
    return "("~asString(x,",")~")";
}


//Basic Operations
function add(x as double[], y as double[])as double[]{
    if(!isVector3D(x))return add(copy(V000),y);
    if(!isVector3D(y))return add(x,copy(V000));
    return [x[0]+y[0], x[1]+y[1], x[2]+y[2]]as double[];
}
function stretch(x as double[], y as double[])as double[]{
    if(!isVector3D(x) || !isVector3D(y))return copy(V000);
    return [
        x[0]*y[0],
        x[1]*y[1],
        x[2]*y[2]
    ];
}


function dot(x as double[], y as double[])as double{
    if(!isVector3D(x) || !isVector3D(y))return 0.0;
    return x[0]*y[0]+x[1]*y[1]+x[2]*y[2];
}
function cross(x as double[], y as double[])as double[]{
    if(!isVector3D(x) || !isVector3D(y))return copy(V000);
    return [
        x[1]*y[2]- x[2]*y[1], 
        x[2]*y[0]- x[0]*y[2], 
        x[0]*y[1]- x[1]*y[0]
    ];
}


function perpendicular(x as double[], y as double[])as bool{
    return dot(x,y)==0;
}
function para(x as double[], y as double[])as bool{
    if(isZero(x) || isZero(y))return true;
    return x[0]*y[1]*y[2] == x[1]*y[0]*y[2]  &&  x[1]*y[0]*y[2] ==x[2]*y[0]*y[1];
}
function divide(x as double[], y as double[])as double{
    if(!para(x,y))return 0.0;
    if(isZero(y))return 0.0;
    if(y[0]!=0.0)return x[0]/y[0];
    if(y[1]!=0.0)return x[1]/y[1];
    return x[2]/y[2];
}


function angleRadian(x as double[], y as double[])as double{
    if(isZero(x)||isZero(y))return 0.0;
    return PIE/2-asin(dot(x,y)/length(x)/length(y));
}
function rotate(a as double[], axisIn as double[], angle as double) as double[]{
    if(!isVector3D(a) || !isVector3D(axisIn))return copy(V000);
    if(isZero(axisIn))return copy(V000);
    var axis=unify(axisIn);
    return add(scale(a, cosf(angle)),
        add(
            scale(cross(axis,a),sinf(angle)),
            scale(axis,dot(a,axis)*(1.0-cosf(angle)))
        )
    );
}

//Combined Operations
function scale(x as double[], ratio as double)as double[]{
    return stretch(x, [ratio,ratio,ratio]as double[]);
}
function reverse(x as double[])as double[]{
    return scale(x,-1.0);
}
function subtract(x as double[], y as double[])as double[]{
    return add(x,reverse(y));
}
function combine(x as double[], y as double[], ratio as double)as double[]{
    return add(scale(x,1.0-ratio),scale(y,ratio));
}

function length(x as double[])as double{
    return Math.sqrt(dot(x,x));
}
function unify(x as double[])as double[]{
    if(isZero(x))return copy(V000);
    else return scale(x, 1.0/length(x));
}

function project(x as double[], y as double[]) as double[]{
    if(isZero(y))return copy(V000);
    return scale(y, dot(x,y)/dot(y,y));
}
function angle(a as double[], b as double[])as double{
    return angleRadian(a,b) *180/PIE;
}
function rot(a as double[], axisIn as double[], angle as double) as double[]{
    return rotate(a,axisIn,angle);
}
function rotRadian(a as double[], axisIn as double[], angle as double) as double[]{
    return rotate(a,axisIn,angle*180/PIE);
}
function eulaAng(x as double[], ang as double[])as double[]{
    var a = copy(ang);
    return rot(rot(rot(x,VX,a[0]),VY,a[1]),VZ,a[2]);
}
function disc(x as double[],y as double[],theta as double)as double[]{
    return add(scale(x,cos(theta)),scale(y,sin(theta)));
}
function discR(x as double[],y as double[],theta as double)as double[]{
    return add(scale(x,cosR(theta)),scale(y,sinR(theta)));
}
//print(para([PIE,PIE,PIE],[1.14,1.14,1.14]));

//Random
function randomUnitVector(world as IWorld)as double[]{
    var p as double[]= [
        randDouble(1.0,-1.0,world),
        randDouble(1.0,-1.0,world),
        randDouble(1.0,-1.0,world)
    ];
    if(isZero(p))return randomUnitVector(world);
    else return unify(p);
}

//Line Related Calculations         //Lines should be represented by giving two points, since all other contents in this file are point based.
function getFootPoint(point as double[], linePointA as double[], linePointB as double[])as double[]{
    var dir = subtract(linePointA,linePointB);
    if(isZero(dir))return point;
    return add( linePointA , project( subtract(point, linePointA) , dir ));
}
function pointLineDist(point as double[], linePointA as double[], linePointB as double[])as double{
    return length(subtract(point, getFootPoint(point,linePointA,linePointB)));
}
function pointSegmentDist(point as double[], linePointA as double[], linePointB as double[])as double{
    var A = copy(linePointA);
    var B = copy(linePointB);
    var C = getFootPoint(point,A,B);
    var AC= subtract(C,A);
    var BC= subtract(C,B);
    if(angle(AC,BC)>90.0)return pointLineDist(point,A,B);
    else return Math.min(length(subtract(point,A)),length(subtract(point,B)));
}

function lineDist(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    var dir1=subtract(l1B,l1A);
    var dir2=subtract(l2B,l2A);
    if(para(dir1,dir2))return pointLineDist(l1A,l2A,l2B);
    else return length(project(subtract(l1A,l2A),cross(dir1,dir2)));
}
function lineFoot(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double[]{
    var dir1=subtract(l1B,l1A);
    var dir2=subtract(l2B,l2A);
    if(para(dir1,dir2))return l1A;
    var dir3=cross(dir1,dir2);
    var ta = subtract(l1A, getFootPoint(l1A,l2A,l2B));
    var pa = subtract(ta, project(ta, dir3));
    var tb = subtract(l1B, getFootPoint(l1B,l2A,l2B));
    var pb = subtract(tb, project(tb, dir3));
    if(isZero(pa))return l1A;
    if(isZero(pb))return l1B;
    var ratio = divide(pb,pa);
    return combine(l1A,l1B,1.0/(1.0-ratio));
}
function linesDist(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    return lineDist(l1A,l1B,l2A,l2B);
}
function linesFoot(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double[]{
    return lineFoot(l1A,l1B,l2A,l2B);
}
/*
function lineDistTest(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    return pointLineDist(lineFoot(l1A,l1B,l2A,l2B),l2A,l2B);
}
print(lineDist(V000,VX,VY,VZ));
print(lineDistTest(V000,VX,VY,VZ));
*/
function segmentLineDist(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    var A = copy(l1A);
    var B = copy(l1B);
    var C = lineFoot(A,B,l2A,l2B);
    var AC= subtract(C,A);
    var BC= subtract(C,B);
    if(angle(AC,BC)>90.0)return lineDist(A,B,l2A,l2B);
    else return Math.min(pointLineDist(A,l2A,l2B),pointLineDist(B,l2A,l2B));
}


//The following calculation is questionable.
function segmentDistRaw(l1A as double[], l1B as double[], l2A as double[], l2B as double[], reversed as bool)as double{
    var A = copy(l1A);
    var B = copy(l1B);
    var C = lineFoot(A,B,l2A,l2B);
    var AC= subtract(C,A);
    var BC= subtract(C,B);
    if(angle(AC,BC)<90.0){
        return Math.min(pointSegmentDist(A,l2A,l2B),pointSegmentDist(B,l2A,l2B));
        //If l1//l2, then C=A, AC=0, angle(AC,BC)=0.0
    }
    else{
        if(reversed){
            return lineDist(l1A,l1B,l2A,l2B);
        }
        else{
            return segmentDistRaw(l2A,l2B,A,B,true);
        }
    }
}
function segmentDist(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    return Math.min(
        Math.min(
            Math.min(
                segmentDistRaw(l1A,l1B,l2A,l2B,false),
                segmentDistRaw(l1B,l1A,l2A,l2B,false)
            ),
            Math.min(
                segmentDistRaw(l1A,l1B,l2B,l2A,false),
                segmentDistRaw(l1B,l1A,l2B,l2A,false)
            )
        ),
        Math.min(
            Math.min(
                segmentDistRaw(l2A,l2B,l1A,l1B,false),
                segmentDistRaw(l2B,l2A,l1A,l1B,false)
            ),
            Math.min(
                segmentDistRaw(l2A,l2B,l1B,l1A,false),
                segmentDistRaw(l2B,l2A,l1B,l1A,false)
            )
        )
    );
}
function segmentsDist(l1A as double[], l1B as double[], l2A as double[], l2B as double[])as double{
    return segmentDist(l1A,l1B,l2A,l2B);
}
/*
print(segmentDist([16.0,0.0,2.7],[-16.0,0.0,2.7],[-17.0,0.0,0.0],[-6.0,0.0,0.0]));
print(segmentDist([-17.0,0.0,0.0],[-6.0,0.0,0.0],[16.0,0.0,2.7],[-16.0,0.0,2.7]));
print(segmentDist([16.0,0.0,2.7],[-16.0,0.0,2.7],[-7.0,0.0,0.0],[-6.0,0.0,0.0]));
print(segmentDist([-7.0,0.0,0.0],[-6.0,0.0,0.0],[16.0,0.0,2.7],[-16.0,0.0,2.7]));
print(segmentDist([-17.0,0.0,0.0],[-6.0,0.0,0.0],[6.0,0.0,2.7],[16.0,0.0,1.7]));*/

zenClass polyhedron{
    var vertexes as double[][]=[];
    var sides as int[][]=[];
    zenConstructor ( vs as double[][] , s as int[][] ){
        for v in vs{
            if(v.length<3)continue;
            vertexes+=[v[0],v[1],v[2]]as double[];
        }
        for s0 in s{
            if(s0.length<2)continue;
            sides+=[s0[0],s0[1]]as int[];
        }
    }
    function copy()as polyhedron{
        return polyhedron(vertexes,sides);
    }
}
static TETRA_HEDRON as polyhedron = polyhedron(
    [[1.0,1.0,1.0],[1.0,-1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,1.0,-1.0]],
    [[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]]
);
static CUBE as polyhedron = polyhedron(
    [[1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],[-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]],
    [[0,1],[0,2],[0,4],[1,3],[1,5],[2,3],[2,6],[3,7],[4,5],[4,6],[5,7],[6,7]]
);
static OCTA_HEDRON as polyhedron = polyhedron(
    [[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0],[-1.0,0.0,0.0],[0.0,-1.0,0.0],[0.0,0.0,-1.0]],
    [[0,1],[0,2],[0,4],[0,5],[1,2],[1,3],[1,5],[2,3],[2,4],[3,4],[3,5],[4,5]]
);
static DODECA_HEDRON as polyhedron = polyhedron(
    [
        [0.0,0.618034,1.618034],[0.618034,1.618034,0.0],[1.618034,0.0,0.618034],
        [0.0,0.618034,-1.618034],[0.618034,-1.618034,0.0],[-1.618034,0.0,0.618034],
        [0.0,-0.618034,1.618034],[-0.618034,1.618034,0.0],[1.618034,0.0,-0.618034],
        [0.0,-0.618034,-1.618034],[-0.618034,-1.618034,0.0],[-1.618034,0.0,-0.618034],
        [1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],
        [-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]
    ],
    [
        [0,12],[1,12],[2,12],   [1,13],[3,13],[8,13],   [2,14],[4,14],[6,14],   [4,15],[8,15],[9,15],
        [0,16],[5,16],[7,16],   [3,17],[7,17],[11,17],  [5,18],[6,18],[10,18],  [9,19],[10,19],[11,19],
        [0,6],[1,7],[2,8],[3,9],[4,10],[5,11]
    ]
);
static ICOSA_HEDRON as polyhedron = polyhedron(
    [
        [0.0,1.0,1.618034],[1.0,1.618034,0.0],[1.618034,0.0,1.0],
        [0.0,1.0,-1.618034],[1.0,-1.618034,0.0],[-1.618034,0.0,1.0],
        [0.0,-1.0,1.618034],[-1.0,1.618034,0.0],[1.618034,0.0,-1.0],
        [0.0,-1.0,-1.618034],[-1.0,-1.618034,0.0],[-1.618034,0.0,-1.0]
    ],
    [
        [0,1],[0,2],[1,2],  [9,10],[9,11],[10,11],  
        [0,5],[0,7],[5,7],  [1,3],[1,8],[3,8],  [2,4],[2,6],[4,6],
        [3,7],[3,11],[7,11],[4,8],[4,9],[8,9],  [5,6],[5,10],[6,10],
        [0,6],[1,7],[2,8],  [3,9],[4,10],[5,11]
    ]
);
function getPolyhedron(faceNum as int)as polyhedron{
    var n = faceNum;
    if(n==6)return CUBE.copy();
    if(n==8)return OCTA_HEDRON.copy();
    if(n==12)return DODECA_HEDRON.copy();
    if(n==20)return ICOSA_HEDRON.copy();
    return TETRA_HEDRON.copy();
}/*
static STAR_A1 as polyhedron = polyhedron(
    [
        [1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0],
        [-1.0,0.0,0.0],[0.0,-1.0,0.0],[0.0,0.0,-1.0],
        [1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],
        [-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]
    ],
    [
        [0,1],[0,2],[0,4],[0,5],[1,2],[1,3],[1,5],[2,3],[2,4],[3,4],[3,5],[4,5],
        [0,8],[0,9],[0,10],[0,11],  [1,8],[1,9],[1,12],[1,13],  [2,8],[2,10],[2,12],[2,14],
        [3,12],[3,13],[3,14],[3,15],  [4,10],[4,11],[4,14],[4,15],  [5,9],[5,11],[5,13],[5,15]
    ]
);*/
static STAR_A as polyhedron = polyhedron(
    [[1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],[-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]],
    [[0,3],[0,5],[0,6],[3,5],[3,6],[5,6],   [1,2],[1,4],[1,7],[2,4],[2,7],[4,7]]
);
static STAR_B as polyhedron = polyhedron(
    [
        [0.0,1.0,1.618034],[1.0,1.618034,0.0],[1.618034,0.0,1.0],
        [0.0,1.0,-1.618034],[1.0,-1.618034,0.0],[-1.618034,0.0,1.0],
        [0.0,-1.0,1.618034],[-1.0,1.618034,0.0],[1.618034,0.0,-1.0],
        [0.0,-1.0,-1.618034],[-1.0,-1.618034,0.0],[-1.618034,0.0,-1.0]
    ],/*
    [
        [0,1],[0,2],[1,2],  [9,10],[9,11],[10,11],  
        [0,5],[0,7],[5,7],  [1,3],[1,8],[3,8],  [2,4],[2,6],[4,6],
        [3,7],[3,11],[7,11],[4,8],[4,9],[8,9],  [5,6],[5,10],[6,10],
        [0,6],[1,7],[2,8],  [3,9],[4,10],[5,11]
    ]
    */
    [
        [0,3],[0,4],[0,8],[0,10],[0,11],
        [1,4],[1,5],[1,6],[1,9],[1,11],
        [2,3],[2,5],[2,7],[2,9],[2,10],
        [3,4],[3,5],[3,10],
        [4,5],[4,11],
        [5,9],
        [6,7],[6,8],[6,9],[6,11],
        [7,8],[7,9],[7,10],
        [8,10],[8,11],
    ]
);
static STAR_C as polyhedron = polyhedron(
    [
        [0.0,1.0,1.618034],[1.0,1.618034,0.0],[1.618034,0.0,1.0],
        [0.0,1.0,-1.618034],[1.0,-1.618034,0.0],[-1.618034,0.0,1.0],
        [0.0,-1.0,1.618034],[-1.0,1.618034,0.0],[1.618034,0.0,-1.0],
        [0.0,-1.0,-1.618034],[-1.0,-1.618034,0.0],[-1.618034,0.0,-1.0]
    ],
    [
        [0,1],[0,2],[1,2],  [9,10],[9,11],[10,11],  
        [0,5],[0,7],[5,7],  [1,3],[1,8],[3,8],  [2,4],[2,6],[4,6],
        [3,7],[3,11],[7,11],[4,8],[4,9],[8,9],  [5,6],[5,10],[6,10],
        [0,6],[1,7],[2,8],  [3,9],[4,10],[5,11],
        [0,3],[0,4],[0,8],[0,10],[0,11],
        [1,4],[1,5],[1,6],[1,9],[1,11],
        [2,3],[2,5],[2,7],[2,9],[2,10],
        [3,4],[3,5],[3,10],
        [4,5],[4,11],
        [5,9],
        [6,7],[6,8],[6,9],[6,11],
        [7,8],[7,9],[7,10],
        [8,10],[8,11],
    ]
);