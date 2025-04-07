buildscript {
    repositories {
        google()  // Asegúrate de tener este repositorio
        mavenCentral()
    }

    dependencies {
        // El plugin de Google Services debería ser parte de las dependencias aquí
        classpath("com.google.gms:google-services:4.4.2")  // Asegúrate de que esta línea esté presente
    }
}

allprojects {
    repositories {
        google()  // Asegúrate de que esté configurado para todos los proyectos
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
