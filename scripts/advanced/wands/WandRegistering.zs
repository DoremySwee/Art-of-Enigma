#reloadable
#priority 50000
import crafttweaker.data.IData;
import scripts.advanced.libs.Data as D;
import scripts.recipes.libs.Aspects as A;

static rodsData as IData={
    "wood":{
        "itemId":"minecraft:stick",
        "capacity":10,
        "craftCost":0,
        "craftAspects":{}
    },  //If crystals are required for crafting:  +A.arrayToData([1,1,4,5,1,4]), or directly type the data out.
    "livingwood":{
        "itemId":"contenttweaker:wand_rod_livingwood",
        "capacity":12,
        "craftCost":3,
        "craftAspects":{},
        "botRodData":{
            "capacity":20
        }
    },
    "dreamwood":{
        "itemId":"contenttweaker:wand_rod_dreamwood",
        "capacity":50,
        "craftCost":10,
        "craftAspects":{},
        "botRodData":{
            "capacity":80
        }
    }
};

static capsData as IData={
    "iron":{
        "itemId":"contenttweaker:wand_cap_iron",
        "multiplier":3.0,
        "discounts":{}, //A.arrayToData([1,1,4,5,1,4])
        "craftCost":0,
        "craftAspects":{}
    },
    "manasteel":{
        "itemId":"contenttweaker:wand_cap_manasteel",
        "multiplier":2.0,
        "discounts":{}, //{"aer":1,"terra":1}
        "craftCost":2,
        "craftAspects":{},
        "botCapData":{
            "manaRate":2000,
            "visRate":0.02
        }
    },
    "elementium":{
        "itemId":"contenttweaker:wand_cap_elementium",
        "multiplier":2.0,
        "discounts":{},
        "craftCost":10,
        "craftAspects":{},
        "botCapData":{
            "manaRate":10000,
            "visRate":0.3
        }
    }
};


//cvis utils
function getVis(data as IData)as double{
    var vis=0.0;
    if(data has "tc.charge")vis+=data.memberGet("tc.charge")as int;
    if(data has "cvis")vis+=data.cvis as double;
    return vis;
}
function formVis(vis as double)as IData{
    var intp as int=vis as int;
    var cvis as double=vis-intp;
    return {"tc.charge":intp,"cvis":cvis}as IData;
}
function setVis(vis as double,dat as IData)as IData{
    return dat+formVis(vis);
}
function addVis(vis as double,dat as IData)as IData{
    return setVis(getVis(dat)+vis,dat);
}