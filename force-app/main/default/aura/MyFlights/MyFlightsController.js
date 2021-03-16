({
    doinit : function(component, event, helper) {
   var action=component.get("c.flightList");
   action.setCallback(this,function(response){
var state =response.getState();
if(state==="SUCCESS"){
component.set("v.flights",response.getReturnValue());

}

   }
   )
$A.enqueueAction(action);
    }
})
