A mansion building resource management game

## Development

### Resource Groups

There are two plugins in use for resource groups that enable efficient management of large data files. 

To add new resources, `.tres` files are created in the `game/data/*` folders for the appropriate entity. Then run `Project > Tools > Rebuild Project Resource Groups` to update the `all_<entities>.tres` file in the `entities` folder. Then run the script `tools/generate_resource_group_refs.gd` to update the generated code that references all entities. If adding a new entity type, the script must be updated to include that. 