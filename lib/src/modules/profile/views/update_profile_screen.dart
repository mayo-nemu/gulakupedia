// // lib/src/modules/auth/screens/profile_setup_screen.dart
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:gulapedia/src/components/form_fields/number_field.dart';
// import 'package:gulapedia/src/components/form_fields/date_picker_field.dart';
// import 'package:gulapedia/src/components/form_fields/dropdown_picker_field.dart';

// import 'package:gulapedia/src/modules/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
// import 'package:user_repository/user_repository.dart';

// class ProfileSetupScreen extends StatefulWidget {
//   final MyUser
//   user; // This user now comes from the extra parameter from SignUpScreen
//   const ProfileSetupScreen({super.key, required this.user});

//   @override
//   State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
// }

// class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
//   final birthdayController = TextEditingController();
//   final weightController = TextEditingController();
//   final heightController = TextEditingController();
//   final bloodSugarsController = TextEditingController();

//   String? _selectedGender;
//   String? _selectedActivities;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers and selected values from widget.user if data exists
//     // This is useful if a user somehow lands here with partial data or for editing profile later
//     if (widget.user.birthday != MyUser.defaultBirthday) {
//       birthdayController.text = DateFormat(
//         'dd - MM - yyyy',
//       ).format(widget.user.birthday);
//     }
//     if (widget.user.weight > 0) {
//       weightController.text = widget.user.weight.toString();
//     }
//     if (widget.user.height > 0) {
//       heightController.text = widget.user.height.toString();
//     }
//     if (widget.user.bloodSugars > 0) {
//       bloodSugarsController.text = widget.user.bloodSugars.toString();
//     }
//     _selectedGender = widget.user.gender.isNotEmpty ? widget.user.gender : null;
//     _selectedActivities = widget.user.activities.isNotEmpty
//         ? widget.user.activities
//         : null;
//   }

//   @override
//   void dispose() {
//     birthdayController.dispose();
//     weightController.dispose();
//     heightController.dispose();
//     bloodSugarsController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<SignUpBloc, SignUpState>(
//       listener: (context, state) {
//         if (state.isSuccess) {
//           // After successful profile update, GoRouter's redirect will
//           // automatically handle navigation based on AuthenticationBloc's updated state.
//           // We can simply go to the main page, and the redirect will check isProfileComplete.
//           // context.go('/catatan-harian'); // This should trigger the redirect if needed
//         }
//         if (state.isFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errorMessage ?? 'Profile setup failed'),
//               backgroundColor: Theme.of(context).colorScheme.error,
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // ... (your existing form fields)
//                     DatePickerField(
//                       controller: birthdayController,
//                       labelText: 'Tanggal Lahir',
//                     ),
//                     const SizedBox(height: 10),
//                     DropdownPickerField(
//                       value: _selectedGender,
//                       items: const ['Laki-laki', 'Perempuan'],
//                       labelText: 'Jenis Kelamin',
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedGender = value;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     NumberField(
//                       controller: weightController,
//                       labelText: 'Berat Badan (kg)',
//                     ),
//                     const SizedBox(height: 10),
//                     NumberField(
//                       controller: heightController,
//                       labelText: 'Tinggi Badan (cm)',
//                     ),
//                     const SizedBox(height: 10),
//                     NumberField(
//                       controller: bloodSugarsController,
//                       labelText: 'Gula Darah (mg/dL)',
//                     ),
//                     const SizedBox(height: 10),
//                     DropdownPickerField(
//                       value: _selectedActivities,
//                       items: const [
//                         'Sedentari',
//                         'Cukup Aktif',
//                         'Aktif',
//                         'Sangat Aktif',
//                       ],
//                       labelText: 'Tingkat Aktivitas',
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedActivities = value;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     BlocBuilder<SignUpBloc, SignUpState>(
//                       builder: (context, state) {
//                         if (state.isLoading) {
//                           return const CircularProgressIndicator();
//                         } else {
//                           return ElevatedButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate() &&
//                                   _selectedGender != null &&
//                                   _selectedActivities != null) {
//                                 final double? parsedWeight = double.tryParse(
//                                   weightController.text,
//                                 );
//                                 final double? parsedHeight = double.tryParse(
//                                   heightController.text,
//                                 );
//                                 final double? parsedBloodSugars =
//                                     double.tryParse(bloodSugarsController.text);

//                                 final DateTime parsedBirthday = DateFormat(
//                                   'dd - MM - yyyy',
//                                 ).parseStrict(birthdayController.text);

//                                 // Use widget.user to ensure userId is retained, then copy other fields
//                                 MyUser myUser = widget.user.copyWith(
//                                   birthday: parsedBirthday,
//                                   gender: _selectedGender!,
//                                   weight: parsedWeight!,
//                                   height: parsedHeight!,
//                                   bloodSugars: parsedBloodSugars!,
//                                   activities: _selectedActivities!,
//                                   isProfileComplete:
//                                       true, // <--- Set this to true!
//                                 );

//                                 context.read<SignUpBloc>().add(
//                                   SignUpEvent.updateProfile(myUser),
//                                 );
//                               }
//                             },
//                             child: Text(
//                               'Simpan',
//                               style: Theme.of(context).textTheme.labelLarge!
//                                   .copyWith(color: Colors.white),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
