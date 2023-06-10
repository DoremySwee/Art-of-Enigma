#loader crafttweaker reloadableevents
#priority 1001
import scripts.LibReloadable as L;
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
static V000 as double[]=[0.0,0.0,0.0]as double[];
static VX as double[]=[1.0,0.0,0.0]as double[];
static VY as double[]=[0.0,1.0,0.0]as double[];
static VZ as double[]=[0.0,0.0,1.0]as double[];
static PIE as double=3.1415927;
static Pie as double=3.1415927;

function isVector3D(a as double[])as bool{
    return a.length==3;
}
function copy(a as double[])as double[]{
    if(!isVector3D(a))return [0.0,0.0,0.0]as double[];
    return [a[0],a[1],a[2]];
}
function toString(a as double[], brackets as bool=true)as string{
    var b as string="";
    for i in a{
        if(b!="")b=b~",";
        b=b~i;
    } 
    if(brackets)return "("~b~")";
    return b;
}
function getPos(entity as crafttweaker.entity.IEntity)as double[]{
    if(isNull(entity))return V000;
    return [entity.x,entity.y,entity.z];
}


function scale(a as double[], r as double)as double[]{
    if(!isVector3D(a))return copy(V000);
    return [a[0]*r, a[1]*r, a[2]*r];
}
function isZero(a as double[])as bool{
    if(!isVector3D(a))return true;
    for i in a {
        if(i!=0)return false;
    }
    return true;
}



function add(a as double[], b as double[]) as double[]{
    if(!isVector3D(a)||!isVector3D(b))return copy(V000);
    return [a[0]+b[0], a[1]+b[1], a[2]+b[2]] as double[];
}
function reverse(a as double[]) as double[]{
    if(!isVector3D(a))return copy(V000);
    return [-a[0],-a[1],-a[2]];
}
function combine(a as double[], b as double[], r as double) as double[]{
    return add(scale(a,r),scale(b,1.0-r));
}
function subtract(a as double[], b as double[]) as double[]{
    return add(a, reverse(b));
}

function stretch(a as double[], b as double[]) as double[]{
    if(!isVector3D(a) || !isVector3D(b))return copy(V000);
    return [a[0]*b[0],a[1]*b[1],a[2]*b[2]];
}



function dotProduct(a as double[], b as double[])as double{
    if(!isVector3D(a) || !isVector3D(b))return 0.0 as double;
    return (a[0]*b[0]+a[1]*b[1]+a[2]*b[2]) as double;
}
function crossProduct(a as double[], b as double[]) as double[]{
    if(!isVector3D(a) || !isVector3D(b))return copy(V000);
    return [a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0]];
}
function dot(a as double[], b as double[])as double{
    return dotProduct(a,b);
}
function cross(a as double[], b as double[])as double[]{
    return crossProduct(a,b);
}



function length(a as double[])as double{
    return Math.sqrt(dot(a,a));
}
function unify(a as double[])as double[]{
    if(isZero(a))return copy(V000);
    return scale(a,1.0/length(a));
}
function project(a as double[], b as double[]) as double[]{
    if(isZero(b))return copy(V000);
    return scale(b, dot(a,b)/dot(b,b));
}
function angleRadian(a as double[], b as double[])as double{
    if(isZero(a)||isZero(b))return 0.0;
    return PIE/2-Math.asin(dot(a,b)/length(a)/length(b));
}
function angle(a as double[], b as double[])as double{
    if(isZero(a)||isZero(b))return -114514.0;
    return angleRadian(a,b) *180/PIE;
}



function rotate(a as double[], axisIn as double[], angle as double) as double[]{
    if(!isVector3D(a) || !isVector3D(axisIn))return copy(V000);
    if(isZero(axisIn))return copy(V000);
    var axis=unify(axisIn);
    return add(scale(a, L.cosf(angle)),
        add(
            scale(cross(axis,a),  L.sinf(angle)),
            scale(axis,dot(a,axis)*(1.0-L.cosf(angle)))
        )
    );
}
function rotateRadian(a as double[], axis as double[], angle as double) as double[]{
    return rotateRadian(a, axis, angle/PIE*180.0);
}
function rot(a as double[], axis as double[], angle as double) as double[]{
    return rotate(a, axis, angle);
}


function randomUnitVector()as double[]{
    var ans as double[]=[Math.random()*2- 1,Math.random()*2- 1,Math.random()*2- 1];
    if(isZero(ans))return randomUnitVector();
    return unify(ans);
}


static tetraHedron as double[][]=[
    [1.0,1.0,1.0],[1.0,-1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,1.0,-1.0]
];
static cube as double[][]=[
    [1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],
    [-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]
];
static octaHedron as double[][]=[
    [1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0],
    [-1.0,0.0,0.0],[0.0,-1.0,0.0],[0.0,0.0,-1.0]
];
static dodecaHedron as double[][]=[
    [0.0,0.618034,1.618034],[0.618034,1.618034,0.0],[1.618034,0.0,0.618034],
    [0.0,0.618034,-1.618034],[0.618034,-1.618034,0.0],[-1.618034,0.0,0.618034],
    [0.0,-0.618034,1.618034],[-0.618034,1.618034,0.0],[1.618034,0.0,-0.618034],
    [0.0,-0.618034,-1.618034],[-0.618034,-1.618034,0.0],[-1.618034,0.0,-0.618034],
    [1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],
    [-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]
];
static icosaHedron as double[][]=[
    [0.0,1.0,1.618034],[1.0,1.618034,0.0],[1.618034,0.0,1.0],
    [0.0,1.0,-1.618034],[1.0,-1.618034,0.0],[-1.618034,0.0,1.0],
    [0.0,-1.0,1.618034],[-1.0,1.618034,0.0],[1.618034,0.0,-1.0],
    [0.0,-1.0,-1.618034],[-1.0,-1.618034,0.0],[-1.618034,0.0,-1.0]
];
static tetraHedronSides as int[][]=[[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]];
static cubeSides as int[][]=[[0,1],[0,2],[0,4],[1,3],[1,5],[2,3],[2,6],[3,7],[4,5],[4,6],[5,7],[6,7]];
static octaHedronSides as int[][]=[[0,1],[0,2],[0,4],[0,5],[1,2],[1,3],[1,5],[2,3],[2,4],[3,4],[3,5],[4,5]];
static dodecaHedronSides as int[][]=[
    [0,12],[1,12],[2,12],   [1,13],[3,13],[8,13],   [2,14],[4,14],[6,14],   [4,15],[8,15],[9,15],
    [0,16],[5,16],[7,16],   [3,17],[7,17],[11,17],  [5,18],[6,18],[10,18],  [9,19],[10,19],[11,19],
    [0,6],[1,7],[2,8],[3,9],[4,10],[5,11]
];
static icosaHedronSides as int[][]=[
    [0,1],[0,2],[1,2],  [3,4],[3,5],[4,5],  [6,7],[6,8],[7,8],  [9,10],[9,11],[10,11],  
    [0,7],[0,8],[1,8],  [3,10],[3,11],[4,1],  [6,1],[6,2],[7,2],  [9,4],[9,5],[10,5],  
    [0,6],[3,9],[1,7],[4,10],[2,4],[5,7],[5,11],[7,11],
];



static star1 as double[][]=[
    [1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0],
    [-1.0,0.0,0.0],[0.0,-1.0,0.0],[0.0,0.0,-1.0],
    [1.0,1.0,1.0],[1.0,1.0,-1.0],[1.0,-1.0,1.0],[1.0,-1.0,-1.0],
    [-1.0,1.0,1.0],[-1.0,1.0,-1.0],[-1.0,-1.0,1.0],[-1.0,-1.0,-1.0]
];
static star1Sides as int[][]=[
    [0,1],[0,2],[0,4],[0,5],[1,2],[1,3],[1,5],[2,3],[2,4],[3,4],[3,5],[4,5],
    [0,8],[0,9],[0,10],[0,11],  [1,8],[1,9],[1,12],[1,13],  [2,8],[2,10],[2,12],[2,14],
    [3,12],[3,13],[3,14],[3,15],  [4,10],[4,11],[4,14],[4,15],  [5,9],[5,11],[5,13],[5,15]
];


function pointLineDistance(linePointA as double[], linePointB as double[], point as double[])as double{
    if(!isVector3D(linePointA)||!isVector3D(linePointB)||!isVector3D(point))return -1.0;
    var direction as double[]=unify(subtract(linePointB, linePointA));
    if(isZero(direction))return -1.0;
    var diff as double[]=subtract(point,linePointB);
    var proj as double[]=project(diff, direction);
    return Math.sqrt(dot(diff,diff)-dot(proj,proj));
}
function pointSegmentDistance(linePointA as double[], linePointB as double[], point as double[])as double{
    var direction as double[]=unify(subtract(linePointB, linePointA));
    var diffA as double[]=subtract(point,linePointA);
    var projA as double[]=project(diffA, direction);
    var diffB as double[]=subtract(point,linePointB);
    var projB as double[]=project(diffB, direction);
    if(angle(diffA,diffB)>90)return Math.sqrt(dot(diffA,diffA)-dot(projA,projA));
    else return Math.min(length(subtract(point,linePointA)),length(subtract(point,linePointB)));
}
//print(length(project(VX,rot(VX,VY,60.0))));
//print(cross(VX,VZ)[1]);
//print(pointLineDistance(V000, VX, VY));
//print(angle(VX,rot(VX,VY,77)));
//print(pointSegmentDistance(VX,V000,VY));
//print(pointSegmentDistance(VX,V000,[0.3,0.3,0.0]));
//print(pointSegmentDistance(VX,V000,[2.0,0.3,0.0]));

function eulaAng(v as double[],x as double,y as double,z as double)as double[]{
    return rot(rot(rot(v,VX,x),VY,y),VZ,z);
}