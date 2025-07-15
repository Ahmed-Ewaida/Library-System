import '../../data/model/profile_model.dart';

abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileError extends ProfileState {
  String message;
  ProfileError({required this.message});
}
class ProfileSuccess extends ProfileState {
  final ProfileModel profileData;
  ProfileSuccess({required this.profileData});
}