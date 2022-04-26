trigger OpportunityUpdateTrigger on Opportunity (after update) {
    
    Opportunity oldOpp = trigger.old[0];
    Opportunity newOpp = trigger.new[0];

    //Check if the new opportunity meets the criteria set by our business logic
    if (newOpp.amount > 100000 && newOpp.stageName == 'Negotiation/Review') {
        System.debug('We need to make changes to the folder structure');
        //IF TRUE, handle the change and update the folder structure
        HandleOpportunityUpdate.HandleOpportunityUpdate(newOpp.Id);
    } else {
        System.debug('No need to make changes at this time.');
    }

}