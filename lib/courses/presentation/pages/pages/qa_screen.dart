import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/widgets/all_widgets.dart';

class QaScreen extends ConsumerWidget {
  const QaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 13),
            QaCard(
              question: 'В чем предназначение ресурса?',
              answer:
                  'Данный ресурс предназначен для получения базовых и углубленных навыков работы с языком SQL.',
            ),
            QaCard(
              question: 'Для кого подойдут эти курсы?',
              answer:
                  'Платформа может использоваться для подготовки специалистов высшего, среднего профессионального и дополнительного профессионального образования, а также всеми желающими освоить SQL.',
            ),
            QaCard(
              question: 'Зачем разработчику изучать базы данных?',
              answer:
                  'Базы данных — это организованная специальным образом структура, которая умеет хранить, обрабатывать и изменять информацию в различных объемах. Если вы будете делать веб-приложение — например интернет-магазин, блог или игры, — почти наверняка вы столкнётесь с базой данных.',
            ),
            QaCard(
              question: 'Почему именно SQL?',
              answer:
                  'SQL — языка для общения с базами данных. Зная синтаксис написания SQL-запроосов, вы сможете работать с любой СУБД: SQLite, MySQL, PostgreSQL, Microsoft SQL Server, Oracle.',
            ),
            SizedBox(height: 69),
          ],
        ),
      ),
    );
  }
}
