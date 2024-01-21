import 'package:flutter/material.dart';

class privacyscreen extends StatefulWidget {
  const privacyscreen({Key? key}) : super(key: key);

  @override
  State<privacyscreen> createState() => _mapScreenState();
}

// TODO: update privacy and policy using website: https://www.freeprivacypolicy.com/live/c5161324-d950-4a25-8ad6-8fb118d32dbe
class _mapScreenState extends State<privacyscreen> {
  TextStyle SubHeading =
      const TextStyle(fontWeight: FontWeight.w500, fontSize: 22);
  TextStyle Heading =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 25,color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Polices'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: 'Last updated: July 01, 2023',
                  style: Heading,
                  children: [
                    TextSpan(
                      text:
                          '\n\nThis Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\nWe use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\nInterpretation,'
                          ' Definitions:',
                      style: SubHeading,
                    ),
                    TextSpan(
                      text: '\n\nInterpretation ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(
                      text:
                          '\n\nThe words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\nDefinitions ',
                      style: SubHeading,
                    ),
                    TextSpan(
                      text: '\n\nFor the purposes of this Privacy Policy:',
                      style: Heading,
                    ),
                    TextSpan(
                      text: '\n\n\t⚈ ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: 'Account',
                      style: SubHeading,
                    ),
                    TextSpan(
                        text:
                            ' means a unique account created for You to access our Service or parts of our Service.',
                        style: Theme.of(context).textTheme.bodyMedium),
                    TextSpan(
                      text: '\n\n\t⚈ ' ,
                      style:Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: 'Affiliate',
                      style: SubHeading,
                    ),
                    TextSpan(
                      text:
                          ' means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Application refers to SIT Mangalore, the software program provided by the Company',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Srinivas Institute of Technology, SRINIVAS INSTITUTE OF TECHNOLOGY A. SHAMA RAO FOUNDATION MANGALURU 574143, KARNATAKA.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\n\t⚈ Country refers to: Karnataka, India',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Personal Data is any information that relates to an identified or identifiable individual.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\n\t ⚈ Service refers to the Application.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text:
                          '\n\n\t⚈ You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\nContact Us',
                      style: SubHeading,
                    ),
                    TextSpan(
                      text:
                          '\n\nIf you have any questions about this Privacy Policy, You can contact us:',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\n\t⚈ By email: srinivasinstitute@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '\n\t⚈ By phone number: 6366410494',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
