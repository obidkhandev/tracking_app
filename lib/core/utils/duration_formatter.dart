String formatDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n"; // 10 dan katta bo‘lsa, o‘zini qaytaradi
    return "0$n"; // 10 dan kichik bo‘lsa, oldiga 0 qo‘shadi
  }

  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));

  return "$hours:$minutes:$seconds"; // Natijani formatlaydi
}