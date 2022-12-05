source "docker" "installshield" {
    image = "mcr.microsoft.com/windows:1809"
    windows_container = true
    commit = true
}

build {
    sources = ["source.docker.installshield"]

    provisioner "file" {
        source = "InstallShield2021R2StandaloneBuild.exe"
        destination = "c:\\Temp"
    }

    provisioner "windows-shell" {
        inline = ["'c:\\Temp\\InstallShield2021R2StandaloneBuild.exe' /s /v'INSTALLLEVEL=101 SABCONTAINER=1 /qn'"]
    }

    provisioner "powershell" {
        inline = ["Remove-Item c:\\Temp"]
    }

    post-processors {
        post-processor "docker-tag" {
            repository = "${var.dockerlogin}/${var.dockerproject}"
            tags = ["v0.2"]
        }
        post-processor "docker-push" {
            login = true
            login_username = var.dockerlogin
            login_password = var.dockerpat
        }
    }
}