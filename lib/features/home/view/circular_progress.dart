part of 'home_view.dart';

final class _CustomCircularProgress extends StatelessWidget {
  const _CustomCircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        backgroundColor: Colors.transparent, child: CircularProgressIndicator());
  }
}
