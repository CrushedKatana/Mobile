import 'package:flutter/material.dart';
import '../models/data_layer.dart';

// Praktikum 2: State management dengan InheritedNotifier untuk single Plan
class PlanScreenPraktikum2 extends StatefulWidget {
  const PlanScreenPraktikum2({super.key});

  @override
  State createState() => _PlanScreenPraktikum2State();
}

class _PlanScreenPraktikum2State extends State<PlanScreenPraktikum2> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Untuk Praktikum 2, kita buat provider lokal dengan ValueNotifier<Plan>
    return PlanProviderPraktikum2(
      notifier: ValueNotifier<Plan>(const Plan()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Praktikum 2 - Master Plan Charel'),
          backgroundColor: Colors.orange,
        ),
        body: _buildBody(),
        floatingActionButton: _buildAddTaskButton(context),
      ),
    );
  }

  Widget _buildBody() {
    return Builder(
      builder: (context) {
        return ValueListenableBuilder<Plan>(
          valueListenable: PlanProviderPraktikum2.of(context),
          builder: (context, plan, child) {
            return Column(
              children: [
                Expanded(child: _buildList(plan)),
                SafeArea(child: Text(plan.completenessMessage)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    return Builder(
      builder: (builderContext) {
        return FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ValueNotifier<Plan> planNotifier =
                PlanProviderPraktikum2.of(builderContext);
            Plan currentPlan = planNotifier.value;
            planNotifier.value = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)..add(const Task()),
            );
          },
        );
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      keyboardDismissBehavior: Theme.of(context).platform == TargetPlatform.iOS
          ? ScrollViewKeyboardDismissBehavior.onDrag
          : ScrollViewKeyboardDismissBehavior.manual,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<Plan> planNotifier = PlanProviderPraktikum2.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = planNotifier.value;
          planNotifier.value = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: task.description,
                complete: selected ?? false,
              ),
          );
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          Plan currentPlan = planNotifier.value;
          planNotifier.value = Plan(
            name: currentPlan.name,
            tasks: List<Task>.from(currentPlan.tasks)
              ..[index] = Task(
                description: text,
                complete: task.complete,
              ),
          );
        },
      ),
    );
  }
}

// Provider khusus untuk Praktikum 2 (single Plan)
class PlanProviderPraktikum2 extends InheritedNotifier<ValueNotifier<Plan>> {
  const PlanProviderPraktikum2(
      {super.key, required Widget child, required ValueNotifier<Plan> notifier})
      : super(child: child, notifier: notifier);

  static ValueNotifier<Plan> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PlanProviderPraktikum2>()!
        .notifier!;
  }
}
