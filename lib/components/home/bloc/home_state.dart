enum TabTypes { unknown, reportList, addBug,account }

class HomeState {
  final TabTypes activeTab;
  final String title;

  const HomeState({
     required this.activeTab,
     required this.title
  });

  HomeState copyWith({
     TabTypes? activeTab,
     String? title
  }) {
    return HomeState(
        activeTab: activeTab ?? this.activeTab,
        title: title ?? this.title
    );
  }
}