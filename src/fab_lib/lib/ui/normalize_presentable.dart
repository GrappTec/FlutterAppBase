part of fab_lib;

class NormalizePresentable {
	static String formatDateTime(DateTime value) => ExDateTime.format(value);
	static String formatDateTimeWithoutSeconds(DateTime value) => ExDateTime.formatWithoutSeconds(value);

	static String formatString(String value) => value ?? '';
}