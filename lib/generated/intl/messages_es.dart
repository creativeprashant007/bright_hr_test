// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "comments": MessageLookupByLibrary.simpleMessage("Comentarios"),
        "error_loading_comments": MessageLookupByLibrary.simpleMessage(
            "Error al cargar los comentarios."),
        "error_saving_post":
            MessageLookupByLibrary.simpleMessage("Error al guardar el post."),
        "failed_to_load_post_details": MessageLookupByLibrary.simpleMessage(
            "Error al cargar los detalles del post."),
        "internet_not_available": MessageLookupByLibrary.simpleMessage(
            "No hay internet disponible. Solo puedes leer los posts guardados."),
        "no_post_available":
            MessageLookupByLibrary.simpleMessage("No hay posts disponibles."),
        "post_details":
            MessageLookupByLibrary.simpleMessage("Detalles del post"),
        "post_not_found_in_saved_posts": MessageLookupByLibrary.simpleMessage(
            "No se encontró el post en los posts guardados."),
        "posts": MessageLookupByLibrary.simpleMessage("Posts"),
        "save": MessageLookupByLibrary.simpleMessage("Guardar"),
        "save_post": MessageLookupByLibrary.simpleMessage("Guardar post"),
        "saved": MessageLookupByLibrary.simpleMessage("Guardado"),
        "saved_posts": MessageLookupByLibrary.simpleMessage("Posts guardados"),
        "something_went_wrong":
            MessageLookupByLibrary.simpleMessage("¡Algo salió mal!"),
        "technical_test": MessageLookupByLibrary.simpleMessage(
            "Prueba técnica de Flutter brillante"),
        "title":
            MessageLookupByLibrary.simpleMessage("Demostración de Flutter"),
        "view_comments": MessageLookupByLibrary.simpleMessage("Ver comentarios")
      };
}
