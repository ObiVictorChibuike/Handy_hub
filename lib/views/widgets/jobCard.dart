import 'package:esolink/logic/api_services/constants.dart';
import 'package:esolink/models/account/job_response_model.dart';
import 'package:flutter/material.dart';
import 'custom_date.dart';

class jobs_Card extends StatefulWidget {
  final RequestedService? jobs;
  const jobs_Card({Key? key, this.jobs}) : super(key: key);

  @override
  State<jobs_Card> createState() => _jobs_CardState();
}

class _jobs_CardState extends State<jobs_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .17,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2),
              spreadRadius: 1, blurRadius: 1,
              offset: const Offset(1, 1,),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 60, width: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle,),
                        child: Image.network(widget.jobs?.photoUrl ?? imagePlaceHolder),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Text(widget.jobs?.jobStatusId == 1 ?
                    'Pending' : widget.jobs?.jobStatusId == 2 ? "Running" :
                    widget.jobs?.jobStatusId == 3 ? "Cancelled" : "Completed" ,
                      style: const TextStyle(fontSize: 10, color: Color(0XFF187226)),)
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.jobs?.fullName }", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xff4F4F4F), fontSize: 12),),
                    Text(widget.jobs?.email ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.
                        copyWith(color: const Color(0xff4F4F4F), fontSize: 12, fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        const Icon(Icons.edit_calendar, size: 18,),
                        const SizedBox(width: 10,),
                        Text(CustomDate.slash(widget.jobs?.createdOn.toString() ?? DateTime.now().toString()), style: const TextStyle(color: Color(0XFF828282), fontSize: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Color(0XFF219653),size: 18,),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.jobs?.phoneNumber ?? "",
                            style: Theme.of(context).textTheme.bodyLarge?.
                            copyWith(color: const Color(0xff4F4F4F), fontSize: 12, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
