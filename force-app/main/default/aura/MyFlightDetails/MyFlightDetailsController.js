({
    cancele : function(component,event,helper){
        var action=component.get("c.cancelTicket");
       // var thedate=component.get("v.fli.departureDate");
     //   var conver=thedate.toDate();
       // console.log(conver);
        var item=component.get("v.oneFli.Name");
        console.log(item);
          action.setParams({"fle":item});
         // console.log(item);
          action.setCallback(this,function(Response){
           var state=Response.getState();
           if(state==="SUCCESS"){
          /* var messagea=$A.get("e.force:showToast");
          messagea.setParams({"message":"Ticket cancellation  Pending Approval","type":"Success"})
          messagea.fire();*/
           }
    
          })
            $A.enqueueAction(action);
      
    }
})
