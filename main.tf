resource "snowflake_grant_privileges_to_database_role" "grant_privileges_to_database_roles" {
  for_each = var.grant_privileges_to_database_roles

  database_role_name   = each.value.database_role_name
  all_privileges       = each.value.all_privileges
  always_apply         = each.value.always_apply
  always_apply_trigger = each.value.always_apply_trigger
  on_database          = each.value.on_database
  privileges           = each.value.privileges
  with_grant_option    = each.value.with_grant_option

  dynamic "on_schema" {
    for_each = each.value.on_schema != null ? [each.value.on_schema] : []
    content {
      all_schemas_in_database    = on_schema.value.all_schemas_in_database
      future_schemas_in_database = on_schema.value.future_schemas_in_database
      inherited                  = on_schema.value.inherited
      schema_name                = on_schema.value.schema_name
    }
  }

  dynamic "on_schema_object" {
    for_each = each.value.on_schema_object != null ? [each.value.on_schema_object] : []
    content {
      dynamic "all" {
        for_each = on_schema_object.value.all != null ? [on_schema_object.value.all] : []
        content {
          in_database        = all.value.in_database
          in_schema          = all.value.in_schema
          object_type_plural = all.value.object_type_plural
        }
      }
      dynamic "future" {
        for_each = on_schema_object.value.future != null ? [on_schema_object.value.future] : []
        content {
          in_database        = future.value.in_database
          in_schema          = future.value.in_schema
          object_type_plural = future.value.object_type_plural
        }
      }
      dynamic "inherited" {
        for_each = on_schema_object.value.inherited != null ? [on_schema_object.value.inherited] : []
        content {
          in_database        = inherited.value.in_database
          in_schema          = inherited.value.in_schema
          object_type_plural = inherited.value.object_type_plural
        }
      }
      object_name = on_schema_object.value.object_name
      object_type = on_schema_object.value.object_type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

