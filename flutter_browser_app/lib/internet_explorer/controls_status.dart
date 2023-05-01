
class IEControlsStatus {
  final bool loading;
  final bool canBack;
  final bool canForward;

  const IEControlsStatus({
    required this.loading,
    required this.canBack,
    required this.canForward,
  });

  factory IEControlsStatus.start() {
    return const IEControlsStatus(
      loading: false,
      canBack: false,
      canForward: false,
    );
  }

  IEControlsStatus start() {
    return IEControlsStatus(
      loading: true,
      canBack: canBack,
      canForward: canForward,
    );
  }

  IEControlsStatus end() {
    return IEControlsStatus(
      loading: false,
      canBack: canBack,
      canForward: canForward,
    );
  }

  IEControlsStatus sync({ required canBack, required canForward }) {
    return IEControlsStatus(
      loading: loading,
      canBack: canBack,
      canForward: canForward,
    );
  }
}