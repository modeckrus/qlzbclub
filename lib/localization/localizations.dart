import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode!.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ?? AppLocalizations();
  }

  String get title {
    return Intl.message(
      'My Application',
      name: 'title',
      desc: 'Title for the Weather Application',
    );
  }
  String get instructionVerifyEmail{
    return Intl.message('Check ur email, and verify address');
  }
  String get link{
    return Intl.message('Link', name: 'link');
  }
  String get bio{
    return Intl.message('Bio', name: 'bio');
  }
  String get verifyEmail{
    return Intl.message('Verify Email', name: 'verifyEmail');
  }
  String get file {
    return Intl.message('File', name: 'file');
  }

  String get test {
    return Intl.message('Test', name: 'test');
  }

  String get gallary {
    return Intl.message('Gallary', name: 'gallary');
  }

  String get youcantundoit {
    return Intl.message('You Can\'t undo it', name: 'youcantundoit');
  }

  String get close {
    return Intl.message('Close', name: 'close');
  }

  String get clearCache {
    return Intl.message('Clear Cache', name: 'clearCache');
  }

  String get choosePhoto {
    return Intl.message('Choose Photo', name: 'choosePhoto');
  }

  String get editProfile {
    return Intl.message('Edit Profile', name: 'editProfile');
  }

  String get username {
    return Intl.message('Username', name: 'username');
  }

  String get titleAddTests {
    return Intl.message('Test', name: 'titleAddTests');
  }

  String get profile {
    return Intl.message('Profile', name: 'profile');
  }

  String get total {
    return Intl.message('Total', name: 'total');
  }

  String get lectures {
    return Intl.message('Lectures', name: 'lectures');
  }

  String get curriculum {
    return Intl.message('Curriculum', name: 'curriculum');
  }

  String get whatYouWillLearn {
    return Intl.message('What I Will Learn?', name: 'whatYouWillLearn');
  }

  String get removing {
    return Intl.message('Removing...', name: 'removing');
  }

  String get howmuchtime {
    return Intl.message('How much time this will take in minutes',
        name: 'howmuchtime');
  }

  String get shortDesc {
    return Intl.message('Write Short Description on top', name: 'shortDesc');
  }

  String get requirements {
    return Intl.message('Requirements', name: 'requirements');
  }

  String get deploy {
    return Intl.message('Deploy', name: 'deploy');
  }

  String get rollUp {
    return Intl.message('Roll Up', name: 'rollUp');
  }

  String get doesNotExist {
    return Intl.message('File does not Exist', name: 'doesNotExist');
  }

  String get learnPath {
    return Intl.message('Learn Path', name: 'learnPath');
  }

  String get descPath {
    return Intl.message('Description Path', name: 'descPath');
  }

  String get writeCurriculumDescTitle {
    return Intl.message('Write Description for ur curriculum',
        name: 'writeCurriculumDescTitle');
  }

  String get writeCurriculumLearnTitle {
    return Intl.message('Describe what people will learn during your program',
        name: 'writeCurriculumDescTitle');
  }

  String get writeCurriculumTitle {
    return Intl.message('Curriculum', name: 'writeCurriculumTitle');
  }

  String get titleAddCurriculum {
    return Intl.message('Add Curriculum', name: 'titleAddCurriculum');
  }

  String get stateSelector {
    return Intl.message('Select item', name: 'stateSelector');
  }

  String get titleAddUnit {
    return Intl.message('Add Unit', name: 'titleAddUnit');
  }

  String get humanPath {
    return Intl.message('Path readable', name: 'humanPath');
  }

  String get moderateArticleTitle {
    return Intl.message('Moderate Article', name: 'moderateArticleTitle');
  }

  String get moderateTestsTitle {
    return Intl.message('Moderate Test', name: 'moderateTestsTitle');
  }

  String get titleModerateAddArticle {
    return Intl.message('Publish Article', name: 'titleModerateAddArticle');
  }

  String get titleModerateAddTests {
    return Intl.message('Publish Test', name: 'titleModerateAddTests');
  }

  String get titleModerateAddLesson {
    return Intl.message('Moderate Lesson', name: 'titleModerateAddLesson');
  }

  String get titleModerateAddUnit {
    return Intl.message('Moderate Unit', name: 'titleModerateAddUnit');
  }

  String get moderateGroupTitle {
    return Intl.message('Moderate Group', name: 'moderateGroupTitle');
  }

  String get titleAddLesson {
    return Intl.message('Add Lesson', name: 'titleAddLesson');
  }

  String get moderateTextTestTitle {
    return Intl.message('Moderate Text Test', name: 'moderateTextTestTitle');
  }

  String get moderateCheckTestTitle {
    return Intl.message('Moderate Check Test', name: 'moderateCheckTestTitle');
  }

  String get moderationTitle {
    return Intl.message('Moderate', name: 'moderationTitle');
  }

  String get storagePath {
    return Intl.message('Storage path', name: 'storagePath');
  }

  String get ok {
    return Intl.message('Ok', name: 'ok');
  }

  String get writeArticleTitle {
    return Intl.message('Write Article', name: 'writeArticleTitle');
  }

  String get writeTestsTitle {
    return Intl.message('Write Test', name: 'writeTestsTitle');
  }

  String get path {
    return Intl.message('Path', name: 'path');
  }

  String get titleTextTest {
    return Intl.message('Text Test', name: 'titleTextTest');
  }

  String get titleCheckTest {
    return Intl.message('Check Test', name: 'titleCheckTest');
  }

  String get titleAddFormula {
    return Intl.message('Math/Chemical formula', name: 'titleAddFormula');
  }

  String get titleAddArticle {
    return Intl.message('Add Article', name: 'titleAddArticle');
  }

  String get settings {
    return Intl.message('Settings', name: 'settings', desc: 'Settings button');
  }

  String get somethingWentWrond {
    return Intl.message('Something Went Wrond',
        name: 'somethingWentWrond', desc: 'somethingWentWrond in reading page');
  }

  String get themeOfApp {
    return Intl.message('App theme',
        name: 'themeOfApp', desc: 'Application theme');
  }

  String get systemThemeMode {
    return Intl.message('System', name: 'systemThemeMode', desc: 'System');
  }

  String get darkThemeMode {
    return Intl.message('Dark', name: 'darkThemeMode', desc: 'Dark');
  }

  String get lightThemeMode {
    return Intl.message('Light', name: 'lightThemeMode', desc: 'Light');
  }

  String get library {
    return Intl.message('Library',
        name: 'library', desc: 'Library on bottom navbar');
  }

  String get account {
    return Intl.message('Account', name: 'account', desc: 'account on navbar');
  }

  String get rewritePass {
    return Intl.message('ReWrite Pass',
        name: 'rewritePass', desc: 'ReWritePassword');
  }

  String get feed {
    return Intl.message('Feed', name: 'feed', desc: 'Feed on navigation bar');
  }

  String get messages {
    return Intl.message('Messgaes',
        name: 'messages', desc: 'Messgaes on navigation bar');
  }

  String get button {
    return Intl.message(
      'Get the Weather',
      name: 'button',
      desc: 'get weather button',
    );
  }

  String get homescreen {
    return Intl.message('HomeScreen',
        name: 'homescreen', desc: 'HomeScreen text');
  }

  String get singin {
    return Intl.message('Sing In', name: 'singin');
  }

  String get passwordnotsame {
    return Intl.message('Password not same', name: 'passwordnotsame');
  }

  String get invalidpassword {
    return Intl.message('Invalid Password', name: 'invalidpassword');
  }

  String get invalidemail {
    return Intl.message('Invalid Email', name: 'invalidemail');
  }

  String get registre {
    return Intl.message('Registre', name: 'registre');
  }

  String get createanaccount {
    return Intl.message('Create an account', name: 'createanaccount');
  }

  String get password {
    return Intl.message('Password', name: 'password');
  }

  String get email {
    return Intl.message('Email', name: 'email');
  }

  String get invalidEmail {
    return Intl.message('Invalid email', name: 'invalidEmail');
  }
  String get invalidPassword {
    return Intl.message('Invalid password', name: 'invalidPassword');
  }

  String get login {
    return Intl.message('Login', name: 'login');
  }

  String get settingthedate {
    return Intl.message('We setting ur data', name: 'settingthedate');
  }

  String get failure {
    return Intl.message('Failure', name: 'failure');
  }

  String get loading {
    return Intl.message('Loading', name: 'loading');
  }

  String get succes {
    return Intl.message('Succes', name: 'succes');
  }

  String get invalidnick {
    return Intl.message('Invalid Nick', name: 'invalidnick');
  }

  String get nick {
    return Intl.message('Nick', name: 'nick');
  }

  String get invalidsurname {
    return Intl.message('Invalid Surname', name: 'invalidsurname');
  }

  String get surname {
    return Intl.message('Surname', name: 'surname');
  }

  String get name {
    return Intl.message('Name', name: 'name');
  }

  String get invalidname {
    return Intl.message('Invalid Name', name: 'invalidname');
  }

  String get urnameandnick {
    return Intl.message('Your name and Nick', name: 'urnameandnick');
  }

  String get singup {
    return Intl.message('Sing Up', name: 'singup');
  }

  String get singinwithgoogle {
    return Intl.message('Sing In with Google', name: 'singinwithgoogle');
  }

  String get error {
    return Intl.message('Error', name: 'error');
  }

  String get titleAddState {
    return Intl.message('Add State', name: 'titleAddState');
  }

  String get titleAddGroup {
    return Intl.message('Add Group', name: 'titleAddGroup');
  }

  String get formula {
    return Intl.message('Formula', name: 'formula');
  }

  String get topTextforaddState {
    return Intl.message(
        'Here you can add your state or create a new group for it and many other',
        name: 'topTextforaddState');
  }

  String get langof {
    return Intl.message('Choose the lang  ', name: 'langof');
  }

  String get justTitle {
    return Intl.message('Title', name: 'justTitle');
  }

  String get addTags {
    return Intl.message('Add tags. Use space to separate the tags',
        name: 'addTags');
  }

  String get addTitle {
    return Intl.message('Add title', name: 'addTitle');
  }

  String get home {
    return Intl.message('Home', name: 'home');
  }

  String get tag {
    return Intl.message('Tag', name: 'tag');
  }

  String get more {
    return Intl.message('More', name: 'more');
  }

  String get selectTextNav {
    return Intl.message(
        'You are in selectable mod, to disable it, push button on top',
        name: 'selectTextNav');
  }

  String get putFormula {
    return Intl.message('Put the formula here', name: 'putFormula');
  }

  String get render {
    return Intl.message('Render', name: 'render');
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
