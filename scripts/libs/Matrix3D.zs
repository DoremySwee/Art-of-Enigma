#loader crafttweaker reloadableevents
#priority 1000
#norun
import mods.ctutils.utils.Math;
import crafttweaker.data.IData;
import scripts.libs.Vector3D;

static PIE as double=3.1415927;
static I as double[][]=[[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0]];
static Z as double[][]=[[0.0,0.0,0.0],[0.0,0.0,0.0],[0.0,0.0,0.0]];


function isMatrix3D(a as double[][])as bool{
    if(a.length!=3)return false;
    for i in a{
        if(i.length!=3)return false;
    }
    return true;
}
function copy(a as double[][])as double[][]{
    if(!isMatrix3D(a))return [[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0]];
    return [
        [a[0][0],a[0][1],a[0][2]],
        [a[1][0],a[1][1],a[1][2]],
        [a[2][0],a[2][1],a[2][2]]
    ];
}


function formFromRow(a as double[],b as double[],c as double[])as double[][]{
    if(!Vector3D.isVector3D(a)||!Vector3D.isVector3D(b)||!Vector3D.isVector3D(c))return copy(I);
    return [a,b,c];
}
function transpose(a as double[][])as double[][]{
    if(!isMatrix3D(a))return copy(I);
    return [
        [a[0][0],a[1][0],a[2][0]],
        [a[0][1],a[1][1],a[2][1]],
        [a[0][2],a[1][2],a[2][2]]
    ];
}
function formFromBasis(a as double[], b as double[], c as double[])as double[][]{
    return transpose(formFromRow(a,b,c));
}


function add(a as double[][], b as double[][])as double[][]{
    if(isMatrix3D(a)&&isMatrix3D(b)){
        var ans as double[][]=copy(Z);
        for i in 0 to 3{
            for j in 0 to 3{
                ans[i][j]=a[i][j]+b[i][j];
            }
        }
        return ans;
    }
    else return copy(I);
}
function scale(a as double[][], r as double)as double[][]{
    if(isMatrix3D(a)){
        var b=copy(a);
        for i in b{
            for j in i{
                j=j*r;
            }
        }
        return b;
    }
    else return copy(I);
}
function subtract(a as double[][], b as double[][])as double[][]{
    return add(a,scale(b,-1.0));
}


function product(a as double[][], b as double[][])as double[][]{
    if(isMatrix3D(a)&&isMatrix3D(b)){
        var c=copy(Z);
        for i in 0 to 3{
            for j in 0 to 3{
                for k in 0 to 3{
                    c[i][j]+=a[i][k]*b[k][j];
                }
            }
        }
        return c;
    }
    else return copy(I);
}
function determinant(a as double[][])as double{
    if(isMatrix3D(a)){
        return a[0][0]*(a[1][1]*a[2][2]-a[1][2]*a[2][1])-
                a[0][1]*(a[1][0]*a[2][2]-a[1][2]*a[2][0])+
                a[0][2]*(a[1][0]*a[2][1]-a[1][1]*a[2][0]);
    }
    else return 0;
}
/*
function adjugate(a as double[][])as double[][]{

}
function inverse(a as double[][])as double[][]{

}
*/