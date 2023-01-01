import yaml
import glob

directories = list()

for compose_filepath in glob.glob("../applications/**/*.yml", recursive=True):
    directories.append(compose_filepath)

for file in directories:
    print(f"Trying: {file}")
    with open(file, "r") as docker_compose_file:
        yml = yaml.safe_load(docker_compose_file)
        services = yml["services"]
        container_name = str(list(services)[0])
        ports = services.get(container_name).get("ports")

        with open("./ports", "w") as output:
            # A compose file could have 1+ ports
            for i in ports:
                host_port = i.split(":")[0]
                print(f"Fount port {host_port} ...")

                output.writelines(f"{host_port}\n")
            print("Finished writing ports to file...")

