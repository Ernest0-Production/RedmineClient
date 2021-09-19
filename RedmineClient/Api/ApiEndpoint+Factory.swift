//
//  ApiEndpoint+Factory.swift
//  RedmineClient
//
//  Created by Ernest Babayan on 19.09.2021.
//


extension ApiEndpoint {

    // MARK: - PROJECTS

    static func projects() -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects.json",

            method: Method.get,

            task: Task.none
        )
    }

    static func project(_ id: Project.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects/\(id.rawValue).json",

            method: Method.get,

            task: Task.none
        )
    }

    static func createProject(
        name: String,
        id: Project.ID,
        description: String? = nil,
        homepage: String? = nil,
        isPublic: Bool,
        parentProject: Project.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects.json",

            method: Method.post,

            task: Task.formData([
                "name": name,
                "identifier": id,
                "description": description,
                "homepage": homepage,
                "is_public": isPublic,
                "parent_id": parentProject,
            ])
        )
    }

    static func archivingProject(_ id: Project.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects/\(id.rawValue)/archive.json",

            method: Method.put,

            task: Task.none
        )
    }

    static func unarchivingProject(_ id: Project.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects/\(id.rawValue)/unarchive.json",

            method: Method.put,

            task: Task.none
        )
    }

    static func deleteProject(_ id: Project.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/projects/\(id.rawValue).json",

            method: Method.delete,

            task: Task.none
        )
    }

    // MARK: - PROJECT MEMBERSHIPS

    static func memberships(of project: Project.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/memberships/\(project).json",

            method: Method.get,

            task: Task.none
        )
    }

    static func addMembership(
        _ user: User.ID,
        role: User.Role.ID,
        in project: Project.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/memberships/\(project).json",

            method: Method.post,

            task: Task.json([
                "membership": [
                    "user_id": user,
                    "role_ids": role,
                ]
            ])
        )
    }

    static func updateMembershipRole(
        _ user: User.ID,
        newRole: User.Role.ID,
        in project: Project.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/memberships/\(project).json",

            method: Method.put,

            task: Task.json([
                "membership": [
                    "user_id": user,
                    "role_ids": newRole,
                ]
            ])
        )
    }

    static func deleteMemberships(
        in project: Project.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/memberships/\(project).json",

            method: Method.delete,

            task: Task.none
        )
    }

    // MARK: - ISSUES

    static func issues() -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues.json",

            method: Method.get,

            task: Task.none
        )
    }

    static func issue(_ id: Issue.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues/\(id).json",

            method: Method.get,

            task: Task.none
        )
    }

    static func createIssue(
        project: Project.ID,
        tracker: Tracker.ID,
        status: Issue.Status.ID,
        priority: Issue.Priority.ID,
        subject: String,
        description: String?,
        category: Issue.Category.ID?,
        assignedUser: User.ID?,
        parentIssue: Issue.ID?,
        isPrivate: Bool
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues.json",

            method: Method.post,

            task: Task.formData([
                "project_id": project,
                "tracker_id": tracker,
                "status_id": status,
                "priority_id": priority,
                "subject": subject,
                "description": description,
                "category_id": category,
                "assigned_to_id": assignedUser,
                "parent_issue_id": parentIssue,
                "is_private": isPrivate,
            ])
        )
    }

    static func deleteIssue(_ id: Issue.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues/\(id).json",

            method: Method.delete,

            task: Task.none
        )
    }

    static func addWatcher(
        _ user: User.ID,
        to issue: Issue.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues/\(issue)/watchers.json",

            method: Method.post,

            task: Task.formData(["user_id": user])
        )
    }

    static func deleteWatcher(
        _ user: User.ID,
        from issue: Issue.ID
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/issues/\(issue)/watchers/\(user).json",

            method: Method.delete,

            task: Task.none
        )
    }

    // MARK: - USERS

    static func users() -> ApiEndpoint {
        ApiEndpoint(
            path: "/users.json",

            method: Method.get,

            task: Task.none
        )
    }

    static func createUser(
        username: String,
        login: String,
        password: CreatedUserPassword,
        firstName: String,
        lastName: String,
        email: String,
        mustChangePassword: Bool,
        needSendInformation: Bool
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/users.json",

            method: Method.post,

            task: Task.json([
                "user": AnyDictionary([
                    "user": username,
                    "login": login,
                    "password": password.value,
                    "firstname": firstName,
                    "lastname": lastName,
                    "mail": email,
                    "must_change_passwd": mustChangePassword,
                    "generate_password": password.isGenerated,
                    "send_information": needSendInformation,
                ])
            ])
        )
    }

    static func currentUser() -> ApiEndpoint {
        ApiEndpoint(
            path: "/users/current.json",

            method: Method.get,

            task: Task.none
        )
    }

    static func user(_ id: User.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/users/\(id).json",

            method: Method.get,

            task: Task.none
        )
    }

    static func updateUser(
        username: String? = nil,
        login: String? = nil,
        password: CreatedUserPassword? = nil,
        firstName: String? = nil,
        lastName: String? = nil,
        email: String? = nil,
        mustChangePassword: Bool? = nil,
        needSendInformation: Bool? = nil,
        admin: Bool? = nil
    ) -> ApiEndpoint {
        ApiEndpoint(
            path: "/users.json",

            method: Method.put,

            task: Task.json([
                "user": AnyDictionary([
                    "user": username,
                    "login": login,
                    "password": password?.value,
                    "firstname": firstName,
                    "lastname": lastName,
                    "mail": email,
                    "must_change_passwd": mustChangePassword,
                    "generate_password": password?.isGenerated,
                    "send_information": needSendInformation,
                ]),

                "admin": admin
            ])
        )
    }

    static func deleteUser(_ id: User.ID) -> ApiEndpoint {
        ApiEndpoint(
            path: "/users/\(id).json",

            method: Method.delete,

            task: Task.none
        )
    }
}
