public class ExpiredJobScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        Database.executeBatch(new PlacementCategoryBatch(), 200);

    }

}
