trigger Tasktrg on task(after insert) {
   Task[] books = Trigger.new;
   TaskAfter.updateLastActivityCompletedDate(books);
}