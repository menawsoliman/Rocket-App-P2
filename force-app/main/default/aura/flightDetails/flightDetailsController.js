({
    purchaseFlight:function(component,evet,helper){
        var userId=$A.get("$SObjectType.CurrentUser.Id");
        var action=component.get("c.getTicket");
        var item=component.get("v.fli");
        if(userId!=null){
        action.setParams({fle:item,dd:userId});
        console.log(item);
        action.setCallback(this,function(Response){
         var state=Response.getState();
         if(state==="SUCCESS"){
       var messagea=$A.get("e.force:showToast");
        messagea.setParams({"message":"Ticket Purchased successful","type":"Success"})
        messagea.fire();
         }

        })
          $A.enqueueAction(action);
    }else {

      var messagea=$A.get("e.force:showToast");
      messagea.setParams({"message":"you should sign in first to purchase a Ticket","type":"Failed"})
      messagea.fire();
    }
  }
 
})
