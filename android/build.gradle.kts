allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Define a new build directory
val newBuildDir = file(rootProject.projectDir.resolve("../build"))
rootProject.buildDir = newBuildDir

subprojects {
    afterEvaluate {
        buildDir = file("${newBuildDir}/${project.name}")
    }
    evaluationDependsOn(":app")
}

// Task to clean the project
tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
