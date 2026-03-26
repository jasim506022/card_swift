import 'package:card_swift/common/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable custom text form field with label, validation,
/// password toggle, and optional custom decoration.
///
/// Supports:
/// - Email, password, and general text input
/// - Validation via [validator]
/// - Password visibility toggle with [hasPasswordToggle]
/// - Custom [decoration] or default consistent styling

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.label,
    this.autofocus = false,
    this.enabled = true,
    this.obscureText = false,
    this.hasPasswordToggle = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.decoration,
    this.style,
    this.autofillHints,
  });

  /// Placeholder text inside the field
  final String hintText;

  /// Optional label displayed above the field
  final String? label;

  /// Text editing controller
  final TextEditingController controller;

  /// Autofocus on field load
  final bool autofocus;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the text should be obscured (e.g., for passwords)
  final bool obscureText;

  /// Whether to show a password toggle button
  final bool hasPasswordToggle;

  /// Action button on the keyboard (Next, Done, etc.)
  final TextInputAction? textInputAction;

  /// Keyboard input type (email, number, etc.)
  final TextInputType textInputType;

  /// Maximum number of lines (ignored if [obscureText] is true)
  final int maxLines;

  /// Validator for form validation
  final String? Function(String?)? validator;

  /// Called when text changes
  final Function(String)? onChanged;

  /// Called when user submits the field (e.g., presses Done/Enter)
  final Function(String)? onFieldSubmitted;

  /// Custom input decoration (if not provided, default is applied)
  final InputDecoration? decoration;

  /// Custom text style
  final TextStyle? style;

  /// Autofill hints (e.g., [AutofillHints.email], [AutofillHints.password])
  final List<String>? autofillHints;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  /// Controls password visibility when [hasPasswordToggle] is enabled
  late bool _obscureText;

  @override
  void initState() {
    /// Initializes `_obscureText` based on the widget's `obscureText` property.
    _obscureText = widget.hasPasswordToggle ? true : widget.obscureText;

    // If it's a multi-line field, we should never obscure text.
    if (widget.maxLines > 1) {
      _obscureText = false;
    } else {
      _obscureText = widget.hasPasswordToggle ? true : widget.obscureText;
    }

    super.initState();
  }

  /// Toggles the visibility of password text
  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.label != null
          ? EdgeInsets.symmetric(vertical: 10)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Displays the label if provided.
          if (widget.label != null)
            Text(widget.label!, style: Theme.of(context).textTheme.labelMedium),

          /// Adds spacing between label and input field.
          SizedBox(height: 10.h),
          TextFormField(
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            controller: widget.controller,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            validator: widget.validator,
            obscureText: _obscureText,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            autofillHints: widget.autofillHints,
            onFieldSubmitted: widget.onFieldSubmitted,
            style: widget.style ?? AppTextStyle.inputLabel,

            /// Applies custom or default decoration
            decoration:
                widget.decoration ??
                CustomTextFieldDecoration.inputDecoration(
                  isEnable: widget.enabled,
                  hintText: widget.hintText,
                  isShowPassword: widget.hasPasswordToggle,
                  isPasswordObscured: _obscureText,
                  onPasswordToggle: widget.hasPasswordToggle
                      ? _togglePasswordVisibility
                      : null,
                ),
          ),
        ],
      ),
    );
  }
}

/// Provides reusable input decoration for text fields.
/// Supports password toggle, enable/disable states, and custom borders.
class CustomTextFieldDecoration {
  // Default border for text fields
  static InputBorder _defaultBorder([Color? borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
    borderRadius: BorderRadius.circular(15.r),
  );

  /// Returns pre-defined InputDecoration with options:
  /// - show/hide password toggle
  /// - hint text
  /// - obscure text mode
  /// - enable/disable field
  /// - callback for password visibility toggle
  static InputDecoration inputDecoration({
    bool isShowPassword = false,
    required String hintText,
    bool isPasswordObscured = false,
    bool isEnable = true,
    VoidCallback? onPasswordToggle,
  }) {
    // Understand the code
    return InputDecoration(
      fillColor: isEnable ? Colors.white : Colors.red,
      filled: true,
      hintText: hintText,
      enabledBorder: _defaultBorder(),
      focusedBorder: _defaultBorder(),
      disabledBorder: _defaultBorder(Colors.black),
      errorBorder: _defaultBorder(Colors.red),
      focusedErrorBorder: _defaultBorder(Colors.red),
      suffixIcon: isShowPassword
          ? IconButton(
              onPressed: onPasswordToggle ?? () {},
              icon: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: isPasswordObscured ? Colors.black : Colors.red,
              ),
            )
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      hintStyle: AppTextStyle.inputHint,
    );
  }
}

/*


/// A reusable custom text form field with label, validation,
/// password toggle, and optional custom decoration.
///
/// Supports:
/// - Email, password, and general text input
/// - Validation via [validator]
/// - Password visibility toggle with [hasPasswordToggle]
/// - Custom [decoration] or default consistent styling

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.label,
    this.autofocus = false,
    this.enabled = true,
    this.obscureText = false,
    this.hasPasswordToggle = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.decoration,
    this.style,
    this.autofillHints,
  });

  /// Placeholder text inside the field
  final String hintText;

  /// Optional label displayed above the field
  final String? label;

  /// Text editing controller
  final TextEditingController controller;

  /// Autofocus on field load
  final bool autofocus;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the text should be obscured (e.g., for passwords)
  final bool obscureText;

  /// Whether to show a password toggle button
  final bool hasPasswordToggle;

  /// Action button on the keyboard (Next, Done, etc.)
  final TextInputAction? textInputAction;

  /// Keyboard input type (email, number, etc.)
  final TextInputType textInputType;

  /// Maximum number of lines (ignored if [obscureText] is true)
  final int maxLines;

  /// Validator for form validation
  final String? Function(String?)? validator;

  /// Called when text changes
  final Function(String)? onChanged;

  /// Called when user submits the field (e.g., presses Done/Enter)
  final Function(String)? onFieldSubmitted;

  /// Custom input decoration (if not provided, default is applied)
  final InputDecoration? decoration;

  /// Custom text style
  final TextStyle? style;

  /// Autofill hints (e.g., [AutofillHints.email], [AutofillHints.password])
  final List<String>? autofillHints;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  /// Controls password visibility when [hasPasswordToggle] is enabled
  late bool _obscureText;

  @override
  void initState() {
    /// Initializes `_obscureText` based on the widget's `obscureText` property.
    _obscureText = widget.hasPasswordToggle ? true : widget.obscureText;
    super.initState();
  }

  /// Toggles the visibility of password text
  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.label != null
          ? EdgeInsets.symmetric(vertical: 10)
          : EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Displays the label if provided.
          if (widget.label != null)
            Text(
              widget.label!,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

          /// Adds spacing between label and input field.
          // AppsFunction.verticalSpacing(8),
          SizedBox(height: 10),
          TextFormField(
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            controller: widget.controller,
            autofocus: widget.autofocus,
            maxLines: widget.maxLines,
            validator: widget.validator,
            obscureText: _obscureText,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            autofillHints: widget.autofillHints,
            onFieldSubmitted: widget.onFieldSubmitted,
            style:
                widget.style ??
                GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),

            /// Applies custom or default decoration
            decoration:
                widget.decoration ??
                CustomTextFieldDecoration.inputDecoration(
                  isEnable: widget.enabled,
                  hintText: widget.hintText,
                  isShowPassword: widget.hasPasswordToggle,
                  isPasswordObscured: _obscureText,
                  onPasswordToggle: widget.hasPasswordToggle
                      ? _togglePasswordVisibility
                      : null,
                ),
          ),
        ],
      ),
    );
  }
}

/// Provides reusable input decoration for text fields.
/// Supports password toggle, enable/disable states, and custom borders.
class CustomTextFieldDecoration {
  // Default border for text fields
  static InputBorder _defaultBorder([Color? borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
    borderRadius: BorderRadius.circular(15.r),
  );

  /// Returns pre-defined InputDecoration with options:
  /// - show/hide password toggle
  /// - hint text
  /// - obscure text mode
  /// - enable/disable field
  /// - callback for password visibility toggle
  static InputDecoration inputDecoration({
    bool isShowPassword = false,
    required String hintText,
    bool isPasswordObscured = false,
    bool isEnable = true,
    VoidCallback? onPasswordToggle,
  }) {
    return InputDecoration(
      fillColor: isEnable ? Colors.white : Colors.red,
      filled: true,
      hintText: hintText,
      enabledBorder: _defaultBorder(),
      focusedBorder: _defaultBorder(),
      disabledBorder: _defaultBorder(Colors.black),
      errorBorder: _defaultBorder(Colors.red),
      focusedErrorBorder: _defaultBorder(Colors.red),
      suffixIcon: isShowPassword
          ? IconButton(
              onPressed: onPasswordToggle ?? () {},
              icon: Icon(
                isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                color: isPasswordObscured ? Colors.black : Colors.red,
              ),
            )
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
    );
  }
}


 */
