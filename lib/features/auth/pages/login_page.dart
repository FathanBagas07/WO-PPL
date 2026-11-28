
import 'package:material_ui/material_ui.dart';

import '../../../app/app_theme.dart';
import '../../widgets/app_action_button.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/worganice_logo.dart';

class LoginPage extends StatefulWidget {
  final Future<void> Function(String email, String password)?
      onLoginSubmit;

  final VoidCallback? onShowLoginConditions;

  final String roseAssetPath;

  const LoginPage({
    super.key,
    this.onLoginSubmit,
    this.onShowLoginConditions,
    this.roseAssetPath = 'assets/images/botanical_rose.png',
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email wajib diisi.';
    }

    final emailPattern = RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    );

    if (!emailPattern.hasMatch(email)) {
      return 'Format email tidak valid.';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Kata sandi wajib diisi.';
    }

    return null;
  }

  Future<void> _submitLogin() async {
    if (_isLoading) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final loginAction = widget.onLoginSubmit;

    if (loginAction == null) {
      setState(() {
        _errorMessage = 'Layanan login belum tersedia.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await loginAction(
        _emailController.text.trim(),
        _passwordController.text,
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Login gagal. Periksa kembali email dan kata sandi Anda, '
            'atau coba beberapa saat lagi.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _openLoginConditionsSheet() {
    if (widget.onShowLoginConditions != null) {
      widget.onShowLoginConditions!();
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: WOrganiceColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(WOrganiceSpacing.cardRadius),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(WOrganiceSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contoh kondisi login',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: WOrganiceColors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: WOrganiceSpacing.md),

                const _LoginConditionItem(
                  title: 'Admin WO aktif',
                  subtitle:
                      'Dapat mengakses dashboard operasional dan '
                      'mengelola data acara.',
                ),

                const SizedBox(height: WOrganiceSpacing.sm),

                const _LoginConditionItem(
                  title: 'Klien aktif',
                  subtitle:
                      'Dapat mengakses informasi dan acara milik '
                      'sendiri sesuai hak akses.',
                ),

                const SizedBox(height: WOrganiceSpacing.sm),

                const _LoginConditionItem(
                  title: 'Akun nonaktif',
                  subtitle:
                      'Akses ditolak sampai akun diaktifkan '
                      'oleh administrator.',
                ),

                const SizedBox(height: WOrganiceSpacing.md),

                AppActionButton(
                  label: 'Tutup',
                  type: AppActionButtonType.secondary,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WOrganiceColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(
              title: 'WOrganice',
              subtitle: 'Wedding Management',
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: WOrganiceSpacing.lg,
                  vertical: WOrganiceSpacing.md,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: WOrganiceColors.ink,
                              fontWeight: FontWeight.w700,
                            ),
                      ),

                      const SizedBox(height: WOrganiceSpacing.xxs),

                      Text(
                        'Hari istimewa, direncanakan dengan hati.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: WOrganiceColors.muted,
                            ),
                      ),

                      const SizedBox(height: WOrganiceSpacing.md),

                      const Center(
                        child: WOrganiceLogo(
                          size: 92,
                        ),
                      ),

                      const SizedBox(height: WOrganiceSpacing.md),

                      AppTextField(
                        label: 'Email',
                        hint: 'nama@email.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [
                          AutofillHints.username,
                          AutofillHints.email,
                        ],
                        enabled: !_isLoading,
                        validator: _validateEmail,
                      ),

                      const SizedBox(height: WOrganiceSpacing.md),

                      AppTextField(
                        label: 'Kata sandi',
                        hint: 'Masukkan kata sandi',
                        controller: _passwordController,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                        enabled: !_isLoading,
                        validator: _validatePassword,
                        onFieldSubmitted: (_) => _submitLogin(),
                      ),

                      if (_errorMessage != null) ...[
                        const SizedBox(height: WOrganiceSpacing.sm),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(
                            WOrganiceSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: WOrganiceColors.error.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(
                              WOrganiceSpacing.controlRadius,
                            ),
                            border: Border.all(
                              color: WOrganiceColors.error.withValues(
                                alpha: 0.35,
                              ),
                            ),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: WOrganiceColors.error,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],

                      const SizedBox(height: WOrganiceSpacing.lg),

                      AppActionButton(
                        label: 'Masuk',
                        isLoading: _isLoading,
                        enabled: widget.onLoginSubmit != null,
                        onPressed: _submitLogin,
                      ),

                      const SizedBox(height: WOrganiceSpacing.md),

                      Text(
                        'Akun diberikan oleh WO. Hubungi WO jika '
                        'memerlukan bantuan.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: WOrganiceColors.muted,
                            ),
                      ),

                      const SizedBox(height: WOrganiceSpacing.md),

                      AppActionButton(
                        label: 'Lihat contoh kondisi login',
                        type: AppActionButtonType.secondary,
                        onPressed: _openLoginConditionsSheet,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginConditionItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _LoginConditionItem({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: WOrganiceColors.ink,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: WOrganiceSpacing.xxs),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: WOrganiceColors.muted,
              ),
        ),
      ],
    );
  }
}
