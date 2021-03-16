({
    searchflight: function (component,event,helper){
        var action=component.get("c.getFlights");
        var fromOrg=component.get("v.fromorgin");
      //  console.log(fromOrg);
        var todesti=component.get("v.todes");
//console.log(todesti);
        var outdate=component.get("v.outbounddate");
        action.setParams({fro:fromOrg,des:todesti,out:outdate});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.searchre",response.getReturnValue());
            }
           


        })
       $A.enqueueAction(action);

    },
    autoComp : function(component, event, helper) {
       var fromOrg=component.get("v.fromorgin");
       var action=component.get("c.getFrom");
       const querySuggestBox = component.find("query-suggest-box");
       action.setParams({"fo":fromOrg});
       action.setCallback(this,function(response){
           var state=response.getState();
           if(state==="SUCCESS"){
               component.set("v.options",response.getReturnValue());
           }
          
                
       }
       
       )
       if(component.get('v.options') != null && 
       $A.util.hasClass(querySuggestBox, "slds-hide")){
                       $A.util.removeClass(querySuggestBox, 'slds-hide');
                   }
               else if(component.get('v.options') == 0){
                   $A.util.addClass(querySuggestBox, 'slds-hide');
               }
$A.enqueueAction(action);
    },
    autoComp2 : function(component, event, helper) {
        var fromOrg=component.get("v.todes");
        var action=component.get("c.getFrom");
        const querySuggestBox = component.find("query-suggest-box2");
        action.setParams({"fo":fromOrg});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==="SUCCESS"){
                component.set("v.options2",response.getReturnValue());
            }
           
                 
        }
        
        )
        if(component.get('v.options2') != null && 
        $A.util.hasClass(querySuggestBox, "slds-hide")){
                        $A.util.removeClass(querySuggestBox, 'slds-hide');
                    }
                else if(component.get('v.options2') == 0){
                    $A.util.addClass(querySuggestBox, 'slds-hide');
                }
 $A.enqueueAction(action);
     },
    selectf:function(component,event,helper){
        const qrySuggBox = component.find('query-suggest-box');
        const qryBox = component.find('query-box');
        $A.util.addClass(qrySuggBox, 'slds-hide');
      //   component.set("v.fromorgin",event.target.id);
 //   console.log("v.fromorgin");
        qryBox.set('v.value', event.target.id);
        component.set("v.options",null);



    },
    selectf2:function(component,event,helper){
        const qrySuggBox = component.find('query-suggest-box2');
        const qryBox = component.find('query-box2');
        $A.util.addClass(qrySuggBox, 'slds-hide');
      //   component.set("v.todes",event.target.id);
     //    console.log("v.todes");

        qryBox.set('v.value', event.target.id);
        component.set("v.options2",null);


    }
 
})
