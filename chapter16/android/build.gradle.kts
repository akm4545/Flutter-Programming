import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
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
    project.afterEvaluate {
        val androidExtension = project.extensions.findByName("android") as? BaseExtension
        if (androidExtension != null) {
            try {
                val namespaceProp = androidExtension::class.java.getMethod("setNamespace", String::class.java)
                val currentNamespace = androidExtension::class.java.getMethod("getNamespace").invoke(androidExtension) as? String
                if (currentNamespace == null) {
                    namespaceProp.invoke(androidExtension, project.group.toString())
                }
            } catch (e: NoSuchMethodException) {
                // ignore
            }
        }
    }

    project.evaluationDependsOn(":app")
}

//subprojects {
//    project.afterEvaluate {
//        val androidExtension = project.extensions.findByName("android") as? BaseExtension
//        if (androidExtension != null) {
//            try {
//                val namespaceProp = androidExtension::class.java.getMethod("setNamespace", String::class.java)
//                val currentNamespace = androidExtension::class.java.getMethod("getNamespace").invoke(androidExtension) as? String
//                if (currentNamespace == null) {
//                    namespaceProp.invoke(androidExtension, project.group.toString())
//                }
//            } catch (e: NoSuchMethodException) {
//                // ignore
//            }
//        }
//    }
//}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
