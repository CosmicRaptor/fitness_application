
import 'package:fitness_application/core/common/error_text.dart';
import 'package:fitness_application/core/common/loader.dart';
import 'package:fitness_application/features/home/repository/workout_backend_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class StepsCard extends ConsumerWidget {
  const StepsCard({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(scprovider);
    print(steps.value);
    return steps.when(data: (data){
      return SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            //color: Pallet.drawerColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.red,),
                      const SizedBox(width: 10.0,),
                      const Text('Steps', style: TextStyle(fontSize: 20.0),),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          //TODO: show the history of steps here
                          child: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: (){Routemaster.of(context).push('/details');},),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0,),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //add the steps here
                        Flexible(child: Text(data.steps.toString(), style: const TextStyle(fontSize: 50.0))),
                        const SizedBox(width: 10.0,),
                        const Text('steps', style: TextStyle(fontSize: 15.0),),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, error: (error, stacktrace)=> ErrorText(error: error.toString()), loading: (){return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          //color: Pallet.drawerColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.red,),
                    const SizedBox(width: 10.0,),
                    const Text('Steps', style: TextStyle(fontSize: 20.0),),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(icon: const Icon(Icons.arrow_forward_ios), onPressed: (){Routemaster.of(context).push('/details');},),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0,),
              const SizedBox(
                height: 55,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //TODO: add the steps here
                      Flexible(child: Text('0', style: TextStyle(fontSize: 50.0))),
                      SizedBox(width: 10.0,),
                      Text('steps', style: TextStyle(fontSize: 15.0),),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );});
  }
}