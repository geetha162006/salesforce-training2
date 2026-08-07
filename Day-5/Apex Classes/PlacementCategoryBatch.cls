public class PlacementCategoryBatch implements Database.Batchable<SObject> {

    // Select records
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Name FROM Account'
        );
    }

    // Process records
    public void execute(Database.BatchableContext bc, List<SObject> scope) {

        List<Account> accList = (List<Account>)scope;

        for(Account acc : accList){
            System.debug('Processing Account: ' + acc.Name);
        }

    }

    // Finish method
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Job Completed Successfully');
    }
}
