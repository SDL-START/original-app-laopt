import 'package:flutter/material.dart';

class PolicyEn extends StatefulWidget {
  const PolicyEn({super.key});

  @override
  State<PolicyEn> createState() => _PolicyEnState();
}

class _PolicyEnState extends State<PolicyEn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policy'),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(child: Text('LaoPT - POLICY')),
              Center(child: Text('LaoPT - POLICY WORDING')),
              Center(child: Text('COVID-19 HEALTH & LIFE INSURANCE')),
              Text('1. DEFINITIONS'),
              Text(
                  """'“COVID-19" refers to the Coronavirus disease (COVID-19) is an infectious disease caused by the SARS-CoV-2 virus and/or as per latest definition defined by the World HealthOrganization (WHO) and/or the latest definition defined by Ministry of Health of the Lao PDR .“Illness” means the infection of the COVID-19 only in this Insurance policy.“Benefit" shall mean the benefits specified in the Schedule of Benefits shown in Certificate of Insurance.“Hospital” shall mean the hospitals, clinic, or any treatment centers authorized and appointed by the Ministry of Healthof the Lao PDR toprovide hospital services and or treatments for the patient who is diagnosed to be infected by the COVID-19.“Insured” shall mean Insured Person as stated in the Certificate of Insurance."Insurer” shall mean Insee Life Insurance Sole Co., Ltd.“ICU” stands for an Intensive Care Unit (ICU). ICU is maintained on a twenty-four (24) hour basis solely for treatment of patients in critical health condition and is equippedto provide special nursing and medical services."Necessary and Reasonable Charges” shall mean charges incurred in respect of medical service or treatment provided which is appropriate and consistent with the diagnosis and which, in accordance with accepted medicalstandards, could not have been omitted without adversely affecting the Insured Person's medical condition; and that such charges shall not exceed the general level of charges made by other providers in the same locality for such services or supplies. “Period of Insurance" shall mean the period as specified in the Certificate of Insurance and coverage shall commence from the date of arrival to the LAO PDR and shall terminate on the expiry date shown in the Period of Insurance or upon the Insured Person's leave the LAO PDR whichever occurs first.“In-patient” means a person covered who is hospitalized for over 12 consecutive hours.“RT-PCR Test” is a real-time reverse transcription polymerase chain reaction (rRT- PCR) test for the qualitative detection of nucleic acid from SARS-CoV-2.'"""),
              Text('2. COVERAGE'),
              Text(
                  'This insurance policy provides coverage in the event the Insured is diagnosed Positive with COVID-19 by the laboratory authorized and appointed by the Ministry of Health of Lao PDR during the Period of Insurance within the territory of the Lao PDR, the Insurer hereby agrees to pay the Benefit to the Hospital and/or the beneficiary according to the terms and conditions. This insurance policy shall enter to force upon the Insured have fully paid to the Insurer for the premium mentioned in the Schedule/Certificate of Insurance and subject to the terms,exclusions, provisions, the list of benefits and conditions contained therein.'),
              Text('3. BENEFITS'),
              Text(
                  """'A benefit shall be payable when, upon diagnosis of a Registered Medical Practitioner, an Insured Person is diagnosed with COVID-19 via the COVID-19 RT-PCR Test is a real-time reverse transcription polymerase chain reaction (rRT-PCR) test for the qualitative detection of nucleic
        acid from SARS-CoV-2 and is registered as an in- patient in a Hospital or out-patient who has chosen to take the treatment at his or her own
        premise. The Insurer agrees to pay the Necessary and Reasonable and legal in- patient hospitalization expenses relating tothe treatment
        including but not limited to daily room and board in hospital (includes meal provided by the hospital), doctor consultation fees, Covid-19
        test, diagnosis test, hospital general services etc. Diagnostic Test covered under this Policy include: X-ray, Electrocardiograms, Basal
        Metabolism Test and other Laboratory Examinations and Tests, Ultrasound, Endoscopy and Biopsy, CT Scan and MRI Scan. Hospital Services covered under this Policy include: Drugs, Medications, Dressings, Ordinary Splints, Plaster Casts, and Intravenous Infusions;In-Hospital Physician's fee and Nurse's fee; - The cost of Blood or Blood Plasma and its Administration; - Physical Therapy; - Prescribed Take Home Medicines Loss of life indemnity: In the event of the death of an Insured Person due to COVID- 19, INSURER shall also paythe benefit amount shown on the Certificate of Insurance under benefit Loss of Life Indemnity to the beneficiary as stipulated in the policy schedule.In any event, the amount payable shall not more than amount of actual hospital charges or up to maximumlimit stated in the schedule/certificate of insurance.'"""),
              Text('4. EXCLUSIONS'),
              Text(
                  """' a) A pre-existing condition means any injury or sickness for which an Insured Person or his Dependant (if applicable) received consultation, medical treatment, diagnosis, care or service; or took prescribed drugs or medicine prior to the effective date of insurance for that Insured Person. No benefit shall be payable under the Policy and supplementary contracts for pre-existing conditions.
  b)The Insured Person was diagnosed COVID-19 Positive prior to the effective date of insurance.
  c) Any treatment for injury or sickness not related to COVID-19.
  d) Any cost related to or contributed by or as result of any quarantine or isolation whether or not required by the Government and/ or Ministry of Health of LAO PDR and/or any authorized body.
  e) Injures or sickness arising directly from war, declared or undeclared, or any warlike operation, strike, riots, civil commotion, invasion,
  nuclear or chemical contamination, terrorist acts, act of foreign enemy, hostilities,rebellion, revolution, insurrection or military or
  usurped power, or from full time military, naval or air services except national services reservist duty or training.
   f) Injuries and/or Illnesses and/or any costs resulting or arising from or occurring during the commission or perpetration of a violation of law by an Insured Person; All self-inflicted Illnesses or Injuries, suicide or attempted suicide, while sane or insane.
  '"""),
              Text("5. CLAIMS PROCEDURE"),
              Text('5.1 Claim Notification'),
              Text(
                  'The insured and/or Hospital to the insurer must notify the Insurer in writing of the illness immediately of the commencement of such illness covered by this policy. Failure to advise within the specified time shall not invalidate the right of claim if sufficient reasons are given as soon as possible.'),
              Text('5.2 Evidence of Claim'),
              Text('-the Insurer’s Claim form;'),
              Text(
                  ' - original bills or invoices approved by Ministry of Finance, must clearly show the description and unit andtotal prices and the receipt stamp.'),
              Text(
                  '− medical records: discharged bill from Hospital, medical prescriptions, Medical examination book/voucher, diagnoses results, testing results; the treatment documents must contain names of doctors and persons treated, type of illness, details of individual items of medical treatment provided and the dates of treatments.'),
              Text(
                  '− Official death declaration and the confirmation of legal heirs or beneficiaries (in case of death);'),
              Text(
                  'All full set of evidence of claim must be submitted to the Insurer within fourteen (14) days after hospital discharge. Proof of Claim shall include a fully completed claim form supplied by the Insurer.'),
              Text('5.3 Payment of Claim'),
              Text(
                  ' Payment of claims pertaining to the Insured will be made to the Hospital directly and/or on a reimbursement basis to the treatments carried out at the premise of the patient.'),
              Text('6. OTHER INSURANCE'),
              Text(
                  ' In case the insured is entitled and made claim with other policies with the same benefits, the Insurer will pay theamount in excess of the other polices but not over the limits stated in this policy schedule. Even though the insured may give up rights to other insurers, this will not affect the right and duty of the company to pay according to this insurance policy.'),
              Text('7. FRAUD'),
              Text(
                  'If any claim under this Policy shall be in any respect fraudulent or if any fraudulent means or devices shall be used to obtain the Benefit under this Policy INSURER shall have no liability in respect of such claim.'),
              Text('8. MORE THAN ONE CERTIFICATE'),
              Text(
                  'The Insured shall not be insured under more than one COVID-19 LIFE INSURANCE Policy issued by the Insurer.In the event of the Insured being insured under more than one such Certificate of Insurance, the Insurer will consider the Insured to be insured under the Certificate which provides the largest amount of benefit. The Insurer will refund any excess insurance premium payment which may have been made by the Insured.'),
              Text('9. PREMIUM'),
              Text(
                  'During the Period of Insurance, the premium for insurance under this policy shall be based upon the Premium Rates shown in the Certificate of Insurance. Premiums shall be payable up front by the Insured Person as statedin the Certificate of Insurance.'),
              Text('10.NON-RENEWABLE AND NON-CANCELLABLE'),
              Text(
                  'The Policy shall be non-renewable, non-endorseable and non-cancellable. The premium being fully earned oncethe Certificate of Insurance is issued.'),
              Text('11. APPLICABLE LAWa'),
              Text(
                  'This Policy and all rights, obligations and liabilities arising hereunder, shall be construed and determined and may be enforced in accordance with the law of the Lao PDR'),
              Text('12. DISPUTE SETTLEMENT'),
              Text(
                  'All disputes between the Insured Person, Hospital and the INSURER, arising out of or in connection with this Policy, including the interpretation of the terms, conditions, limitations and/or exclusions contained herein shall be settled first through negotiations in good faith. If the parties fail to resolve a dispute by negotiations such dispute shall be submitted to the local court where the Insurer resides.Insee Life Insurance Sole Co., Ltd'),
              Center(child: Text('Insee Life Insurance Sole Co., Ltd'))
            ],
          ),
        ),
      ),
    );
  }
}
