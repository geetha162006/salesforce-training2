public class ExternalPlacementSyncJob implements Queueable {

    public void execute(QueueableContext context){

        System.debug('External Sync Completed');

        System.enqueueJob(
            new PlacementNotificationJob()
        );

    }

}
