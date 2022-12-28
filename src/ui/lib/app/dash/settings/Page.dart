import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:medicamina/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MedicaminaDashSettingsPage extends StatelessWidget {
  const MedicaminaDashSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Widget? widget;
    if (1000 > MediaQuery.of(context).size.width) {
      widget = const MedicaminaDashSettingsMobileWidget();
    } else {
      widget = const MedicaminaDashSettingsDesktopWidget();
    }

    return Scaffold(body: widget);
  }
}

class MedicaminaDashSettingsMobileWidget extends StatefulWidget {
  const MedicaminaDashSettingsMobileWidget({Key? key}) : super(key: key);

  @override
  State<MedicaminaDashSettingsMobileWidget> createState() => _MedicaminaDashSettingsMobileWidget();
}

class _MedicaminaDashSettingsMobileWidget extends State<MedicaminaDashSettingsMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Text('Mobile'),
      ),
    );
  }
}

class MedicaminaDashSettingsDesktopWidget extends StatefulWidget {
  const MedicaminaDashSettingsDesktopWidget({Key? key}) : super(key: key);

  @override
  State<MedicaminaDashSettingsDesktopWidget> createState() => _MedicaminaDashSettingsDesktopWidgetState();
}

class _MedicaminaDashSettingsDesktopWidgetState extends State<MedicaminaDashSettingsDesktopWidget> {
  var email = Modular.get<SupabaseClient>().auth.currentUser!.email;
  String _uri = '';

  void setUri() {
    setState(() {
      _uri = Modular.args.uri.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    setUri();
    Modular.to.addListener(setUri);
  }

  @override
  void dispose() {
    super.dispose();
    Modular.to.removeListener(setUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 6, left: 6, right: 6),
          child: Card(
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 18)),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(88),
                              child: Image.asset(
                                'assets/images/jake_selfie.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 12)),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Text(
                            email != null ? email.toString() : '',
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 12)),
                        const Divider(indent: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(1000, 62),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                              backgroundColor: _uri == '/dash/settings/account' ? Theme.of(context).colorScheme.primary.withOpacity(0.12) : Theme.of(context).buttonTheme.colorScheme?.surface,
                            ),
                            onPressed: () {
                              Modular.to.pushNamedOrPopUntil('./account');
                            },
                            child: const Text(
                              'Account',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.75),
                            ),
                          ),
                        ),
                        const Divider(indent: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(1000, 62),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                              backgroundColor: _uri == '/dash/settings/security' ? Theme.of(context).colorScheme.primary.withOpacity(0.12) : Theme.of(context).buttonTheme.colorScheme?.surface,
                            ),
                            onPressed: () {
                              Modular.to.pushNamedOrPopUntil('./security');
                            },
                            child: const Text(
                              'Security',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.75),
                            ),
                          ),
                        ),
                        const Divider(indent: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(1000, 62),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                              backgroundColor: _uri == '/dash/settings/billing' ? Theme.of(context).colorScheme.primary.withOpacity(0.12) : Theme.of(context).buttonTheme.colorScheme?.surface,
                            ),
                            onPressed: () {
                              Modular.to.pushNamedOrPopUntil('./billing');
                            },
                            child: const Text(
                              'Billing',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.75),
                            ),
                          ),
                        ),
                        const Divider(indent: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(1000, 62),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                              // backgroundColor: Theme.of(context).buttonTheme.colorScheme?.error.withOpacity(0.05),
                              foregroundColor: Colors.red,
                            ),
                            onPressed: () async => showDialog<String>(
                              context: context,
                              builder: (BuildContext _context) => AlertDialog(
                                title: const Text(
                                  'Logout?',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                content: const Text('Are you sure you want to logout?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(_context, 'BACK'),
                                    child: const Text('BACK'),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                                    onPressed: () async {
                                      Navigator.pop(_context, 'CONTINUE');
                                      await Modular.get<SupabaseClient>().auth.signOut();
                                      Modular.to.navigate('/');
                                    },
                                    child: const Text(
                                      'CONTINUE',
                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.75, color: Colors.red),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 6),
                        const Divider(indent: 6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // RIGHT SCREEN
                  const VerticalDivider(
                    width: 1,
                    indent: 6,
                    endIndent: 6,
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      children: const [
                        Expanded(
                          child: RouterOutlet(),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
