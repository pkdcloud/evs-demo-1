package evsdemo1.buildTypes

import jetbrains.buildServer.configs.kotlin.v2019_2.*
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.exec
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.script

object EvsDemo1_Build : BuildType({
    templates(evsdemo1_TfBuildRun)
    id = AbsoluteId("EvsDemo1_Build")
    name = "Build & Deploy"
steps {
    script {
        name = "lint"
        id = "RUNNER_3"
        scriptContent = """echo "[LINT] Linting Project""""
    }
    script {
        name = "static-appliaction--security-testing"
        id = "RUNNER_4"
        scriptContent = """echo "[SAST] Static application security testing""""
    }
    exec {
        name = "terraform-plan"
        id = "RUNNER_1"
        path = "TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-collection make apply"
    }
    script {
        name = "terraform-apply"
        id = "RUNNER_2"
        scriptContent = "TERRAFORM_ROOT_MODULE=horizon TERRAFORM_WORKSPACE=mgmt-apse2-horizon-collection make applyAuto"
    }
    script {
        name = "dynamic-application-code-testing"
        id = "RUNNER_6"
        scriptContent = """echo "[DAST] Dynamic application security testing""""
    }
    script {
        name = "function-testing"
        id = "RUNNER_5"
        scriptContent = """echo "[TEST] Functional Testing""""
    }
    stepsOrder = arrayListOf("RUNNER_3", "RUNNER_4", "RUNNER_1", "RUNNER_2", "RUNNER_6", "RUNNER_5")
}
    requirements {
        matches("teamcity.agent.jvm.os.family", "Linux", "RQ_1")
    }
})