# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Farm.Repo.insert!(%Farm.SomeSchema{})
#

defmodule Seeds do
  alias Farm.Repo
  # alias Farm.User
  alias Farm.Animals.Cow
  alias Farm.Events.Event
  alias Farm.Finance.Procurement
  alias Farm.Finance.Salary
  alias Farm.Finance.Sales
  alias Farm.HR.Duty
  alias Farm.HR.Patron
  alias Farm.HR.Role
  alias Farm.HR.Worker
  alias Farm.Inventory.Product
  alias Farm.Inventory.Machinery
  alias Farm.Inventory.Medicine
  alias Farm.Land.Arable
  alias Farm.Land.Paddock
  alias Farm.Products.Milk

  # @test_role_slug "test-role"
  # User

  @role %{
    name: "Owner"
  }

  @patrons %{
    name: "Mohamed",
    contact: "12345678",
    address: "Nairobi",
    role_id: 1
  }

  @cow %{
    name: "Boran",
    dob: "2009-1-12",
    breed: "boran",
    patron_id: "1"
  }

  @user %{
    id_number: "12345677",
    id_type: "citizen",
    email: @test_user_email,
    password: "tester",
    phone_number: "254123456",
    first_name: "Tester",
    last_name: "Wetu",
    other_name: "O"
  }
  @user2 %{
    id_number: "123423677",
    id_type: "citizen",
    email: @test_user2_email,
    password: "tester2",
    phone_number: "254123456",
    first_name: "Tester",
    last_name: "Wao",
    other_name: "A"
  }

  # User
  @test_admin %{
    id_number: "27248899",
    id_type: "citizen",
    email: @test_admin_email,
    password: "@Stronger1",
    phone_number: "+254726939482",
    first_name: "BENARD",
    last_name: "OKELLO",
    other_name: "GONDWE"
  }

  # Id_types
  @id_type_one %{
    name: "citizen",
    label: "Citizen"
  }
  @id_type_two %{
    name: "alien",
    label: "Residents"
  }
  @id_type_three %{
    name: "visitor",
    label: "Foreign Residents"
  }
  @id_type_four %{
    name: "business",
    label: "Business Entities"
  }

  # Role
  @admin_role %{
    name: "System Admin",
    protected: true
  }

  # Workflow
  @workflow1 %{
    name: "Test Workflow"
  }

  # Role
  @simple_role %{
    name: "Backend User"
  }

  @admin_permission "system.admin"

  # Service Groups
  @service_group_one %{
    name: "Sample Service Group 1",
    slug: "sample-group-1",
    description: "This is a sample service group 1"
  }
  @service_group_two %{
    name: "Sample Service Group 2",
    slug: "sample-group-2",
    description: "This is a sample service group 2"
  }

  @now NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

  def run(env) when env in [:dev, :test] do
    # Data to be seeded on test
    delete_all()

    %{}
    |> seed(env, :id_types)
    |> seed(env, :service_groups)
    |> seed(env, :workflows)
    |> seed(env, :services)
    |> seed(env, :users)
    |> seed(env, :applications)
    |> seed(env, :commands)
    |> seed(env, :permissions)
    |> seed(env, :roles)
    |> seed(env, :user_roles)
    |> seed(env, :api_clients)
  end

  def run(:prod) do
    # Data to be seeded on production
    %{}
    |> seed(:prod, :id_types)
    |> seed(:prod, :permissions)
    |> seed(:prod, :roles)
  end

  defp delete_all() do
    Repo.delete_all(Ledger)
    Repo.delete_all(Invoice)
    Repo.delete_all(ApplCommand)
    Repo.delete_all(EventCommand)
    Repo.delete_all(Appl)
    Repo.delete_all(WorkflowCommand)
    Repo.delete_all(Service.IdType)
    Repo.delete_all(Service)
    Repo.delete_all(ServiceGroup)
    Repo.delete_all(Session)
    Repo.delete_all(User)
    Repo.delete_all(Role)
    Repo.delete_all(UserRole)
    Repo.delete_all(IdType)
    Repo.delete_all(Workflow)
    Repo.delete_all(Farm.APIClient)
  end

  defp seed(data, env, type) do
    result = do_seed(data, env, type)

    data
    |> Map.put(type, result)
  end

  defp do_seed(_data, _env, :api_clients) do
    _ = Farm.APIClient.create(%{name: "nadra"})
  end

  defp do_seed(_data, env, :service_groups) do
    env
    |> get_service_groups()
    |> Enum.map(fn group ->
      {:ok, service_group} = ServiceGroup.create(group)
      service_group
    end)
  end

  defp do_seed(%{service_groups: service_groups, workflows: [workflow]} = _data, _env, :services) do
    service_group_one = service_groups |> Enum.find(&(&1.name == @service_group_one.name))

    services =
      [
        %{
          name: "Test Service",
          prefix: "SRV1",
          workflow_id: workflow.id,
          description: "A service 1",
          validity_period: "1 Year from submission",
          submission_type: "form",
          service_group_id: service_group_one.id,
          form: %{
            schema: %{
              "pages" => [
                %{
                  "elements" => [
                    %{
                      "isRequired" => true,
                      "name" => "name",
                      "placeHolder" => "Jon Snow",
                      "title" => "Please enter your name:",
                      "type" => "text"
                    },
                    %{
                      "allowImagesPreview" => true,
                      "isRequired" => true,
                      "maxSize" => 0,
                      "name" => "bioPic",
                      "storeDataAsText" => false,
                      "title" => "Bio Picture",
                      "type" => "file"
                    },
                    %{
                      "inputType" => "date",
                      "isRequired" => true,
                      "name" => "birthdate",
                      "title" => "Your birthdate:",
                      "type" => "text"
                    },
                    %{
                      "inputType" => "color",
                      "name" => "color",
                      "title" => "Your favorite color:",
                      "type" => "text"
                    },
                    %{
                      "inputType" => "email",
                      "isRequired" => true,
                      "name" => "email",
                      "placeHolder" => "jon.snow@nightwatch.org",
                      "title" => "Your e-mail:",
                      "type" => "text",
                      "validators" => [%{"type" => "email"}]
                    }
                  ],
                  "name" => "page1"
                }
              ]
            }
          },
          application_fee: %{
            currency: "KES",
            pesaflow_service_id: 29,
            items: [
              %{item_type: "service", type: "fixed", amount: %Decimal{coef: 650}, ordering: 2},
              %{item_type: "convenience", type: "fixed", amount: %Decimal{coef: 50}, ordering: 1}
            ]
          },
          service_id_types: [%{id_type_name: "citizen"}],
          backend_service: false
        }
      ]
      |> Enum.map(fn data ->
        %Service{}
        |> Service.changeset(data)
        |> Ecto.Changeset.change(payment_on_submission: true, status: "published")
        |> Service.cast_application_fee()
        |> Repo.insert!()
      end)

    services
  end

  defp do_seed(_data, env, :id_types) do
    types =
      env
      |> get_id_types()
      |> Enum.map(fn type ->
        %{name: type.name, label: type.label, inserted_at: @now, updated_at: @now}
      end)

    {_, _} = Farm.Repo.insert_all(IdType, types, on_conflict: :nothing)
    types
  end

  defp do_seed(_data, env, :workflows) do
    env
    |> get_workflows()
    |> Enum.map(fn item ->
      {:ok, workflows} = Workflow.create(item)
      workflows
    end)
  end

  defp do_seed(_data, env, :users) do
    users =
      env
      |> get_users()
      |> Enum.map(fn user_record ->
        {:ok, user} = User.create(Map.put(user_record, :otp_type, "sms"))
        user
      end)

    users
  end

  defp do_seed(_data, _env, :permissions) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    entries =
      Farm.Roles.Permission.permissions()
      |> Enum.map(fn {slug, name} ->
        %{
          name: name,
          slug: slug,
          inserted_at: now,
          updated_at: now
        }
      end)

    {_, permissions} =
      Repo.insert_all(Farm.Roles.Permission, entries,
        returning: true,
        on_conflict: {:replace, [:name]},
        conflict_target: [:slug]
      )

    permissions
  end

  defp do_seed(data, env, :roles) do
    admin_perm = Enum.find(data.permissions, &(&1.slug == @admin_permission))
    [admin_role | other_roles] = get_roles(env)

    {:ok, admin_role} =
      admin_role
      |> Map.put(:role_permissions, [%{permission_id: admin_perm.id}])
      |> Role.create_role()
      |> elem(1)
      |> Ecto.Changeset.change(protected: true)
      |> Map.put(:action, :update)
      |> Repo.update()

    other_roles =
      other_roles
      |> Enum.map(fn role_record ->
        {:ok, role} = Role.create_role(role_record)
        role
      end)

    [admin_role | other_roles]
  end

  defp do_seed(data, _env, :user_roles) do
    # For the test user
    user = User.get_by(%{"email" => @test_user_email})
    [admin_role, other_role | _] = data.roles
    {:ok, user_role} = UserRole.create(%{"user_id" => user.id, "role_id" => other_role.id})

    # For the test user 2
    user = User.get_by(%{"email" => @test_user2_email})
    {:ok, user_role1} = UserRole.create(%{"user_id" => user.id, "role_id" => other_role.id})

    # For the (test) Admin user
    user = User.get_by(%{"email" => @test_admin_email})
    {:ok, user_role2} = UserRole.create(%{"user_id" => user.id, "role_id" => admin_role.id})

    [user_role, user_role1, user_role2]
  end

  @one_x_one %{
    "name" => "1x1-ccc6f23e-aed0-4c86-8e28-dac4273ef2eb.png",
    "originalName" => "1x1.png",
    "size" => 95,
    "storage" => "base64",
    "type" => "image/png",
    "url" =>
      "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII="
  }

  defp do_seed(data, _env, :applications) do
    [service] = data.services
    user = data.users |> Enum.find(&(&1.email == @test_admin_email))

    {:ok, application} =
      Appl.submit(service, user, %{
        "app_type" => "replace",
        "passport_type" => "ordinary",
        "page_count" => "34",
        # "application_ref" => "PPT-0000001",
        "full_name" => "FOO",
        "given_names" => "BAZ",
        "surname" => "BAR",
        # todo: derive from payment
        "fee_amount" => "4550",
        "passport_number" => "A1234567",
        # todo: formio sends a tz offset in the form +3
        "date_of_birth" => "1981-01-04 00:00:00+03",
        "city_of_birth" => "KISII",
        "country_of_birth" => "KE",
        "gender" => "Male",
        "kra_pin" => "",
        "birth_entry_no" => "0123457",
        "id_number" => "00000000",
        "certificate_no" => "1234567",
        "certificate_date_of_issue" => "1981-02-28",
        "country_of_residence" => "KE",
        "profession" => "Lawyer",
        "height_ft" => "5Feet",
        "height_in" => "05Inch",
        "color_of_eyes" => "Black",
        "special_peculiarities" => "N/A",
        "orignal_name" => "",
        "postal_address" => "12345-00100",
        "tel_number" => "0733000000",
        "fathers_fullname" => "NEMSIUS ANDERSON",
        "fathers_id_number" => "",
        "fathers_passport_no" => "",
        "fathers_place_of_birth" => "",
        "fathers_postal_address" => "",
        "fathers_tel_number" => "",
        "mothers_fullname" => "MARIA TRINITY",
        "mothers_id_number" => "7291660",
        "mothers_passport_no" => "N/A",
        "mothers_place_of_birth" => "KISII",
        "mothers_postal_address" => "12345-00100",
        "mothers_tel_number" => "0737237980",
        "estate_sublocation" => "OBAMA ESTATE",
        "hse_no" => "",
        "home_tel_no" => "",
        "email_address" => "",
        "mobile_phone_no" => "0733603210",
        "citizen_by" => "",
        "marital_status" => "Married",
        "maiden_name" => "",
        "spouses_fullname" => "RONALD SMITH",
        "place_of_marriage" => "",
        "date_of_marriage" => "",
        "reason_for_travel" => "",
        "next_of_kin_fullname1" => "MARIA TRINITY",
        "next_of_kin_division1" => "MARANI",
        "next_of_kin_location1" => "MWAMONARI",
        "next_of_kin_relationship1" => "MOTHER",
        "next_of_kin_id_no1" => "7291660",
        "next_of_kin_postal_address1" => "12345-00100",
        "next_of_kin_tel1" => "0737237980",
        "next_of_kin_email1" => "",
        "next_of_kin_fullname2" => "TOM MORPHEUS",
        "next_of_kin_division2" => "MARANI",
        "next_of_kin_location2" => "MWAMONARI",
        "next_of_kin_relationship2" => "BROTHER",
        "next_of_kin_id_no2" => "10467020",
        "next_of_kin_postal_address2" => "12345-00100",
        "next_of_kin_tel2" => "0722374340",
        "next_of_kin_email2" => "",
        "child_data" => [
          %{
            "child_counter" => 1,
            "fullname" => "amani ochieng",
            "place_of_birth" => "nairobi",
            "date_of_birth" => "2012-12-12",
            "relationship" => "child",
            "gender" => "male"
          }
        ],
        "recommender_name" => "CHIEF AKALA",
        "recommender_identity_card_no" => "00000123",
        "recommender_occupation" => "TEACHER",
        "recommender_email" => "",
        "recommender_telephone_no" => "0727000000",
        "recommender_pobox" => "54321-00100",
        "recommender_date" => "2019-04-01",
        "applicants_id_copy" => @one_x_one,
        "applicants_birth_certificate" => @one_x_one,
        "fathers_id_copy" => @one_x_one,
        "mothers_id_copy" => @one_x_one,
        "recommenders_id_copy" => @one_x_one,
        "previous_passport_bio_data_page" => @one_x_one
      })

    invoice = Invoice.current_by_application(application.id)

    # add payments
    {:ok, _} =
      PaymentNotification.get_or_create!(%{
        bill_ref: Invoice.HashId.encode(invoice.id),
        channel: "pesaflow",
        transaction_ref: "000001",
        transaction_date: "2019-01-01 03:00:00",
        amount: "100",
        payload: %{}
      })
      |> PaymentNotification.process()

    invoice2 = Invoice.current_by_application(application.id)

    {:ok, _} =
      PaymentNotification.get_or_create!(%{
        bill_ref: Invoice.HashId.encode(invoice2.id),
        channel: "pesaflow",
        transaction_ref: "000002",
        transaction_date: "2019-01-02 06:00:00",
        amount: "150",
        payload: %{}
      })
      |> PaymentNotification.process()

    [application]
  end

  defp do_seed(_data, _env, :commands) do
    []
  end

  defp get_users(_env) do
    [@user, @user2, @test_admin]
  end

  defp get_roles(_env) do
    [@admin_role, @simple_role]
  end

  defp get_service_groups(_env) do
    [@service_group_one, @service_group_two]
  end

  defp get_id_types(_env) do
    [@id_type_one, @id_type_two, @id_type_three, @id_type_four]
  end

  defp get_workflows(_env) do
    [@workflow1]
  end

  def put_timestamps(data) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    data
    |> Map.put(:inserted_at, now)
    |> Map.put(:updated_at, now)
  end
end

Seeds.run(Mix.env())
