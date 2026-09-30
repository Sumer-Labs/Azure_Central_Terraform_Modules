package terraform

# --------------------------------------------------
# Required organization-wide tags
# --------------------------------------------------

required_tags := {
    "environment",
    "managed_by"
}


# --------------------------------------------------
# Determine whether a resource is being created
# or updated.
# --------------------------------------------------

is_deployment_change(resource) if {
    resource.change.actions[_] == "create"
}

is_deployment_change(resource) if {
    resource.change.actions[_] == "update"
}


# --------------------------------------------------
# Policy:
# Every Azure managed resource must contain
# all required organization tags.
# --------------------------------------------------

deny contains message if {
    resource := input.resource_changes[_]

    resource.mode == "managed"

    startswith(resource.type, "azurerm_")

    is_deployment_change(resource)

    tags := object.get(resource.change.after, "tags", {})

    required_tag := required_tags[_]

    not tags[required_tag]

    message := sprintf(
        "Resource %q (%s) is missing required tag %q",
        [resource.address, resource.type, required_tag]
    )
}
