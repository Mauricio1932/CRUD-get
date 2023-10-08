abstract class UserEvent {
  const UserEvent();
}

class GetUserRequest extends UserEvent {

}

class ViewUser extends UserEvent{
  const ViewUser(this.userId);
  final int userId;
}
class RemoveViewUser extends UserEvent{
  const RemoveViewUser(this.userId);
  final int userId;
}