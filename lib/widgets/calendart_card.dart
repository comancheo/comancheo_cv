import 'package:comancheo_cv/cubits/base_cubits.dart';
import 'package:comancheo_cv/services/calendar.dart';
import 'package:comancheo_cv/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CalendarCard extends StatefulWidget {
  const CalendarCard({super.key});

  @override
  State<CalendarCard> createState() => _CalendarCardState();
}

class _CalendarCardState extends State<CalendarCard> {
  final CalendarService _calendarService = GetIt.instance<CalendarService>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NullBoolCubit, bool?>(
      bloc: _calendarService.loading,
      builder: (context, loading) {
        return BlocBuilder<ListCubit<String>, List<String>>(
          bloc: _calendarService.namesDay,
          builder: (context, namesDay) {
            return CustomCard(
              width: 155,
              height: 155,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${DateTime.now().day}. ${DateTime.now().month}.\n${DateTime.now().year}', style: Theme.of(context).textTheme.headlineMedium),
                  if (loading == true) ...[
                    const Center(child: CircularProgressIndicator()),
                  ] else if (namesDay.isEmpty) ...[
                    const SizedBox(),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(namesDay.join(', '), style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
