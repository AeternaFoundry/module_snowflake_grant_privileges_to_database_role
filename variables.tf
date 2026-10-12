variable "grant_privileges_to_database_roles" {
  description = <<EOT
Map of grant_privileges_to_database_roles, attributes below
Required:
    - database_role_name
Optional:
    - all_privileges
    - always_apply
    - always_apply_trigger
    - on_database
    - privileges
    - with_grant_option
    - on_schema (block):
        - all_schemas_in_database (optional)
        - future_schemas_in_database (optional)
        - inherited (optional)
        - schema_name (optional)
    - on_schema_object (block):
        - all (optional, block):
            - in_database (optional)
            - in_schema (optional)
            - object_type_plural (required)
        - future (optional, block):
            - in_database (optional)
            - in_schema (optional)
            - object_type_plural (required)
        - inherited (optional, block):
            - in_database (optional)
            - in_schema (optional)
            - object_type_plural (required)
        - object_name (optional)
        - object_type (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - read (optional)
        - update (optional)
EOT

  type = map(object({
    database_role_name   = string
    all_privileges       = optional(bool)
    always_apply         = optional(bool)
    always_apply_trigger = optional(string)
    on_database          = optional(string)
    privileges           = optional(set(string))
    with_grant_option    = optional(bool)
    on_schema = optional(object({
      all_schemas_in_database    = optional(string)
      future_schemas_in_database = optional(string)
      inherited                  = optional(string)
      schema_name                = optional(string)
    }))
    on_schema_object = optional(object({
      all = optional(object({
        in_database        = optional(string)
        in_schema          = optional(string)
        object_type_plural = string
      }))
      future = optional(object({
        in_database        = optional(string)
        in_schema          = optional(string)
        object_type_plural = string
      }))
      inherited = optional(object({
        in_database        = optional(string)
        in_schema          = optional(string)
        object_type_plural = string
      }))
      object_name = optional(string)
      object_type = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }))
  }))
}

