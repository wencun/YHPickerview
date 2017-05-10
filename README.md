# Cordova PickerView Plugin #

## DESCRIPTION ##

* Cordova PickerView Plugin
* This plugin is built for Cordova with ARC.

[![Screenshot](https://raw.githubusercontent.com/zhuifeng1017/YHPickerview/master/Screen%20Shot%201.png)](https://github.com/zhuifeng1017/YHPickerview)
[![Screenshot](https://raw.githubusercontent.com/zhuifeng1017/YHPickerview/master/Screen%20Shot%202.png)](https://github.com/zhuifeng1017/YHPickerview)
[![Screenshot](https://raw.githubusercontent.com/zhuifeng1017/YHPickerview/master/Screen%20Shot%203.png)](https://github.com/zhuifeng1017/YHPickerview)

## PLUGIN SETUP FOR IOS ##
    cordova plugin add https://github.com/zhuifeng1017/YHPickerview.git


## test js ##

    // After device ready, create a local alias
       //      -------------Pickerview usage begin--------------------------
    
    
    // "婚姻状况"
    var options1_selected= [0];
    var options1 ={
        "pickerId":"picker1",
        "title":"婚姻状况",
        "depth":1,
        "selected":options1_selected,
        "options":[
                   {"text": "未婚"},
                   {"text": "已婚未育"},
                   {"text": "已婚已育"},
                   {"text": "离异"},
                   {"text":  "其他"}
                   ]
    };
    
    
    // "紧急联系人"
    var options2_selected= [0, 0];
    var options2 ={
        "pickerId":"picker2",
        "title":"紧急联系人",
        "depth":2,
        "selected":options2_selected,
        "options":[
                   {
                   "text": "第一个紧急联系人",
                   "options":
                   [
                    {"text": "父母"},
                    {"text": "配偶"}
                    ]
                   },
                   
                   {
                   "text": "第二个紧急联系人 ",
                   "options":
                   [
                    {"text": "父母"},
                    {"text": "配偶"},
                    {"text": "兄弟姐妹"},
                    {"text": "亲戚"},
                    {"text": "朋友"},
                    {"text": "同学"},
                    {"text": "同事"}
                    ]
                   }
                   ]
    };
    
    //"职业"
    var options3_selected= [0, 0, 0];
    var options3 ={
        "pickerId":"picker3",
        "title":"职业",
        "depth":3,
        "selected":options3_selected,
        "options":[
                   {
                   "text": "自由职业",
                   "options":
                   [
                    {"text": "无业"},
                    {"text": "务农"},
                    {"text": "家庭主妇"},
                    {"text": "钟点工"},
                    {"text": "临时工"},
                    {"text": "证券投资"},
                    {"text": "个体运输"},
                    {"text": "流动摊贩"},
                    {"text": "游戏代练"},
                    {"text": "其他"}
                    ]
                   },
                   
                   {
                   "text": "工薪族",
                   "options":
                   [
                    {"text": "政府机关"},
                    {"text": "学校"},
                    {"text": "医院",
                    "options":[
                               {"text": "民办",  "id":0},
                               {"text": "1级",  "id":0},
                               {"text": "2级",  "id":0},
                               {"text": "3级",  "id":0},
                               {"text": "其他",  "id":0}
                               ]
                    },
                    {"text": "企业公司",
                    "options":[
                               {"text": "国有",  "id":0},
                               {"text": "股份",  "id":0},
                               {"text": "私营",  "id":0},
                               {"text": "外资",  "id":0},
                               {"text": "合资",  "id":0},
                               {"text": "其他",  "id":0}
                               ]
                    },
                    {
                    "text": "私营商铺"
                    }
                    ]
                   }
                   ]
    };
    
    var showPickerviewBtn1 = document.getElementById("showPickerviewBtn1");
    var showPickerviewBtn2 = document.getElementById("showPickerviewBtn2");
    var showPickerviewBtn3 = document.getElementById("showPickerviewBtn3");
    var hidePickerviewBtn = document.getElementById("hidePickerviewBtn");
    var destoryPickerviewBtn = document.getElementById("destoryPickerviewBtn");
    var pickResultDiv = document.getElementById("pickResult");
    
    var pickSuccess = function(results){
        pickResultDiv.innerText = JSON.stringify(results);
        var pickerId = results["pickerId"];
        
        if (pickerId=="picker1"){
            options1["selected"] = results["selectedIndexArray"];
        }else if (pickerId=="picker2"){
            options2["selected"] = results["selectedIndexArray"];
        }else if (pickerId=="picker3"){
            options3["selected"] = results["selectedIndexArray"];
        }
    }
    
    var pickFailure = function(){
        
    }
    
    hidePickerviewBtn.onclick = function(){
        navagator.YHPickerview.hidePicker("");
    }
    
    destoryPickerviewBtn.onclick = function(){
        navagator.YHPickerview.destoryPicker("");
    }
    
    showPickerviewBtn1.onclick = function(){
        var pickerParams = options1;
        navagator.YHPickerview.showPicker(pickerParams, pickSuccess, pickFailure);
    }
    
    showPickerviewBtn2.onclick = function(){
        var pickerParams = options2;
        navagator.YHPickerview.showPicker(pickerParams, pickSuccess, pickFailure);
    }
    
    showPickerviewBtn3.onclick = function(){
        var pickerParams = options3;
        navagator.YHPickerview.showPicker(pickerParams, pickSuccess, pickFailure);
    }
    //      -------------Pickerview end--------------------------

## test index.html  ##
    <html>
    <body>
        <p>  </p>
        <p>  </p>
        <div id="pickResult"></div>
        <div>
            <p><button id="btn1" style="visibility: hidden">BankCard</button></p>
            <p><button id="showPickerviewBtn1">Pickerview Depth 1</button></p>
            <p><button id="showPickerviewBtn2">Pickerview Depth 2</button></p>
            <p><button id="showPickerviewBtn3">Pickerview Depth 3</button></p>
            
            <p><button id="hidePickerviewBtn">hide Pickerview</button></p>
            <p><button id="destoryPickerviewBtn">destory Pickerview</button></p>
        </div>
    </body>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
    </html>
 
