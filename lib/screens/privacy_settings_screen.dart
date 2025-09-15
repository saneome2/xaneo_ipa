import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Настройки коммуникаций
  String _whoCanMessage = 'contacts'; // 'all', 'contacts', 'nobody'
  String _whoCanRecordVoice = 'contacts';
  String _whoCanCall = 'contacts';
  String _whoCanSendVideo = 'contacts';
  String _whoCanSendLinks = 'all';
  String _whoCanInvite = 'contacts';

  // Настройки видимости профиля
  String _whoSeesNickname = 'all';
  String _whoSeesAvatar = 'all';
  String _whoSeesBirthday = 'contacts';
  String _whoSeesOnlineTime = 'contacts';

  final List<String> _options = ['all', 'contacts', 'nobody'];

  // Метод для расчета горизонтального отступа в зависимости от ориентации
  double _getHorizontalPadding(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // В горизонтальной ориентации делаем поля уже
    if (mediaQuery.orientation == Orientation.landscape) {
      // В альбомной ориентации оставляем только центральную треть экрана для полей
      return screenWidth * 0.25; // 25% отступов с каждой стороны = 50% ширины экрана для полей
    } else {
      // В портретной ориентации используем меньшие отступы для большей ширины
      return 16.0;
    }
  }

  String _getOptionText(String option, AppLocalizations l10n) {
    switch (option) {
      case 'all':
        return l10n.privacyAll;
      case 'contacts':
        return l10n.privacyContacts;
      case 'nobody':
        return l10n.privacyNobody;
      default:
        return option;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.black : Colors.white,
        centerTitle: true,
        title: Text(
          l10n.privacySettingsTitle,
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // Умная прокрутка - не позволяет прокручивать дальше границ
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Раздел коммуникаций
            _buildSectionHeader(l10n.privacyCommunications),
            _buildSettingItem(
              l10n.privacyWhoCanMessage,
              _whoCanMessage,
              (value) => setState(() => _whoCanMessage = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoCanRecordVoice,
              _whoCanRecordVoice,
              (value) => setState(() => _whoCanRecordVoice = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoCanCall,
              _whoCanCall,
              (value) => setState(() => _whoCanCall = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoCanSendVideo,
              _whoCanSendVideo,
              (value) => setState(() => _whoCanSendVideo = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoCanSendLinks,
              _whoCanSendLinks,
              (value) => setState(() => _whoCanSendLinks = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoCanInvite,
              _whoCanInvite,
              (value) => setState(() => _whoCanInvite = value),
            ),

            //const SizedBox(height: 24),

            // Раздел видимости профиля
            _buildSectionHeader(l10n.privacyProfileVisibility),
            _buildSettingItem(
              l10n.privacyWhoSeesNickname,
              _whoSeesNickname,
              (value) => setState(() => _whoSeesNickname = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoSeesAvatar,
              _whoSeesAvatar,
              (value) => setState(() => _whoSeesAvatar = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoSeesBirthday,
              _whoSeesBirthday,
              (value) => setState(() => _whoSeesBirthday = value),
            ),
            _buildSettingItem(
              l10n.privacyWhoSeesOnlineTime,
              _whoSeesOnlineTime,
              (value) => setState(() => _whoSeesOnlineTime = value),
            ),

            //const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final horizontalPadding = _getHorizontalPadding(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade900.withOpacity(0.3) : Colors.grey.shade200.withOpacity(0.5),
      child: Text(
        title,
        style: TextStyle(
          color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingItem(String title, String currentValue, Function(String) onChanged) {
    final l10n = AppLocalizations.of(context);
    final horizontalPadding = _getHorizontalPadding(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.grey.shade800.withOpacity(0.3) : Colors.grey.shade400.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Provider.of<ThemeProvider>(context).isDarkMode ? Colors.white : Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: onChanged,
            itemBuilder: (context) => _options.map((option) {
              return PopupMenuItem<String>(
                value: option,
                child: Text(
                  _getOptionText(option, l10n),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
              );
            }).toList(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800.withOpacity(0.5) : Colors.grey.shade200.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    _getOptionText(currentValue, l10n),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_drop_down,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
        ),
      ),
    );
  }
}
