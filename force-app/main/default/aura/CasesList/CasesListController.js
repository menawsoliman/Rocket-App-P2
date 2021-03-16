({
    doinit : function(component, event, helper) {
component.set('v.columns',[{label:'Case Number',fieldName:'CaseNumber',type:'text'},
{label:'Subject',fieldName:'Subject',type:'text'},
{label:'Contact Name',fieldName:'ContactId',type:'text'},
{label:'Status',fieldName:'Status',type:'text'}
]);
let action=component.get("c.getCases");
action.setCallback(this,function(response){
          let state=response.getState();
          if(state==="SUCCESS"){
          component.set("v.items",response.getReturnValue());
          }else{
              console.log("Failed with state: "+state);
          }

});
$A.enqueueAction(action);


    }
})
