import Fluminus

defmodule LumiapiWeb.UserController do
  use LumiapiWeb, :controller

  def profile(conn, %{"username" => username, "password" => password}) do
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), "/user/Profile")
    json conn, body
  end

  def current_term(conn, %{"username" => username, "password" => password}) do
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), "/setting/AcademicWeek/current?populate=termDetail")
    json conn, body
  end

  def modules(conn, %{"username" => username, "password" => password}) do
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), "/module")
    json conn, body
  end

  def announcements(conn, %{"username" => username, "password" => password, "id" => id}, archived \\ false) do
    uri = "/announcement/#{if archived, do: "Archived", else: "NonArchived"}/#{id}?sortby=displayFrom%20ASC"
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), uri)
    json conn, body
  end

  def getDirectoryChildren(conn, %{"username" => username, "password" => password, "parentID" => id}) do
    uri = "/files/?ParentID=#{id}"
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), uri)
    json conn, body
  end

  def getFileChildren(conn, %{"username" => username, "password" => password, "directoryID" => id, "allowUpload" => allowUpload}) do
    uri = "/files/#{id}/file#{if allowUpload=="true", do: "?populate=Creator", else: ""}"
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), uri)
    json conn, body
  end

  def getDownloadUrl(conn, %{"username" => username, "password" => password, "id" => id}) do
    uri = "/files/file/#{id}/downloadurl"
    {:ok, _, _, %{status_code: 200, body: body}} = raw_api_call(get_auth(username, password), uri)
    json conn, body
  end

  def test(conn, %{"path" => path}) do
    IO.puts(path)
    profile = "{\"id\":\"c3d0054d-391f-4a39-a9b3-a9af2009c4da\",\"userID\":\"e0261956\",\"expireDate\":\"2019-07-02T10:24:15.237+08:00\",\"userNameOriginal\":\"TAN YUANHONG\",\"userMatricNo\":\"A0177903X\",\"nickName\":\"\",\"officialEmail\":\"\",\"email\":\"e0261956@u.nus.edu\",\"displayPhoto\":true}"
    modules = "{\"status\":\"success\",\"code\":200,\"total\":6,\"offset\":0,\"data\":[{\"id\":\"0b4a75e2-1ab2-49a7-a3ed-1e612dd42880\",\"createdDate\":\"2018-12-29T00:22:38.65+08:00\",\"creatorID\":\"27d31529-8a25-42c3-b160-4e9e79c73a2d\",\"lastUpdatedDate\":\"2019-05-03T11:51:46.53+08:00\",\"lastUpdatedBy\":\"27d31529-8a25-42c3-b160-4e9e79c73a2d\",\"name\":\"MA1101R\",\"startDate\":\"2018-12-29T00:21:08.173+08:00\",\"endDate\":\"2019-05-25T11:59:00+08:00\",\"publish\":true,\"parentID\":\"0b4a75e2-1ab2-49a7-a3ed-1e612dd42880\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":false,\"access_Update\":false,\"access_Delete\":false,\"access_Settings_Read\":false,\"access_Settings_Update\":false},\"courseName\":\"Linear Algebra I\",\"facultyCode\":\"32\",\"departmentCode\":\"146\",\"term\":\"1820\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":false,\"copyFromID\":\"00000000-0000-0000-0000-000000000000\",\"l3\":false,\"enableLearningFlow\":true,\"usedNusCalendar\":false,\"isCorporateCourse\":false},{\"id\":\"57290e55-335a-4c09-b904-a795572d6cda\",\"createdDate\":\"2019-02-21T17:38:57.437+08:00\",\"creatorID\":\"4dce39fc-432c-4e4c-aef1-8bb187fcbcc0\",\"lastUpdatedDate\":\"2019-04-09T12:59:58.673+08:00\",\"lastUpdatedBy\":\"4dce39fc-432c-4e4c-aef1-8bb187fcbcc0\",\"name\":\"CS1101S\",\"startDate\":\"2019-02-21T17:37:27.277+08:00\",\"endDate\":\"2020-01-04T23:59:00+08:00\",\"publish\":true,\"parentID\":\"57290e55-335a-4c09-b904-a795572d6cda\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":true,\"access_Update\":true,\"access_Delete\":true,\"access_Settings_Read\":true,\"access_Settings_Update\":true},\"courseName\":\"Programming Methodology\",\"facultyCode\":\"39\",\"departmentCode\":\"252\",\"term\":\"1910\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":false,\"copyFromID\":\"8722e9a5-abc5-4160-820d-bf69d8a63c6f\",\"l3\":false,\"enableLearningFlow\":false,\"usedNusCalendar\":false,\"isCorporateCourse\":false},{\"id\":\"30490a9d-08a9-4594-ab3f-6b1b6c1cc28d\",\"createdDate\":\"2019-01-11T10:08:51.6+08:00\",\"creatorID\":\"39d62b25-a1af-4354-b547-a499559c0f48\",\"lastUpdatedDate\":\"2019-01-11T10:18:22.543+08:00\",\"lastUpdatedBy\":\"6003a58d-e113-4b83-b5aa-744a7ae044c3\",\"name\":\"IS1103\",\"startDate\":\"2019-01-11T10:08:07.593+08:00\",\"endDate\":\"2019-05-31T23:59:00+08:00\",\"publish\":true,\"parentID\":\"30490a9d-08a9-4594-ab3f-6b1b6c1cc28d\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":false,\"access_Update\":false,\"access_Delete\":false,\"access_Settings_Read\":false,\"access_Settings_Update\":false},\"courseName\":\"IS Innovations in Organisations and Society\",\"facultyCode\":\"39\",\"departmentCode\":\"253\",\"term\":\"1820\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":true,\"copyFromID\":\"00000000-0000-0000-0000-000000000000\",\"l3\":false,\"enableLearningFlow\":true,\"usedNusCalendar\":true,\"isCorporateCourse\":false},{\"id\":\"063773a9-43ac-4dc0-bdc6-4be2f5b50300\",\"createdDate\":\"2018-12-26T10:06:02.247+08:00\",\"creatorID\":\"3e3fa871-f4ef-4051-9208-e1207354804c\",\"lastUpdatedDate\":\"2019-01-04T11:35:47.973+08:00\",\"lastUpdatedBy\":\"3e3fa871-f4ef-4051-9208-e1207354804c\",\"name\":\"CS2100\",\"startDate\":\"2018-12-26T10:05:17.467+08:00\",\"endDate\":\"2019-05-25T23:59:00+08:00\",\"publish\":true,\"parentID\":\"063773a9-43ac-4dc0-bdc6-4be2f5b50300\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":false,\"access_Update\":false,\"access_Delete\":false,\"access_Settings_Read\":false,\"access_Settings_Update\":false},\"courseName\":\"Computer Organisation\",\"facultyCode\":\"39\",\"departmentCode\":\"252\",\"term\":\"1820\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":false,\"copyFromID\":\"00000000-0000-0000-0000-000000000000\",\"l3\":false,\"enableLearningFlow\":true,\"usedNusCalendar\":false,\"isCorporateCourse\":false,\"purpose\":\"<p>The objective of this module is to familiarise students with the fundamentals of computing devices. Through this module students will understand the basics of data representation, and how the various parts of a computer work, separately and with each other. This allows students to understand the issues in computing devices, and how these issues affect the implementation of solutions. <br>\\n<br>\\nTopics covered include C programming language, data representation systems, combinational circuits, sequential circuits, assembly language, processor datapath and control, pipelining and cache.</p>\\n\\n<p>Please refer to the module website at <a href=\\\"https://www.comp.nus.edu.sg/~cs2100\\\" target=\\\"_blank\\\">https://www.comp.nus.edu.sg/~cs2100</a></p>\\n\\n<p> </p>\\n\\n<p> </p>\\n\"},{\"id\":\"50af15da-4c10-423c-bbe8-499d3590d72f\",\"createdDate\":\"2019-01-02T09:12:16.357+08:00\",\"creatorID\":\"af295c2d-fb03-49fe-94e7-99e9a35ee389\",\"lastUpdatedDate\":\"2019-01-02T09:12:32.007+08:00\",\"lastUpdatedBy\":\"af295c2d-fb03-49fe-94e7-99e9a35ee389\",\"name\":\"CS2040\",\"startDate\":\"2019-01-02T09:11:03.64+08:00\",\"endDate\":\"2019-05-25T23:59:00+08:00\",\"publish\":true,\"parentID\":\"50af15da-4c10-423c-bbe8-499d3590d72f\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":false,\"access_Update\":false,\"access_Delete\":false,\"access_Settings_Read\":false,\"access_Settings_Update\":false},\"courseName\":\"Data Structures and Algorithms\",\"facultyCode\":\"39\",\"departmentCode\":\"252\",\"term\":\"1820\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":true,\"copyFromID\":\"00000000-0000-0000-0000-000000000000\",\"l3\":false,\"enableLearningFlow\":true,\"usedNusCalendar\":true,\"isCorporateCourse\":false},{\"id\":\"087b320f-aeb8-4cb9-92d9-59a0f0845043\",\"createdDate\":\"2019-01-02T09:07:43.09+08:00\",\"creatorID\":\"fd9cc1ac-826c-4755-a027-bc7fee923d1a\",\"lastUpdatedDate\":\"2019-01-02T09:07:43.09+08:00\",\"lastUpdatedBy\":\"fd9cc1ac-826c-4755-a027-bc7fee923d1a\",\"name\":\"CS2030\",\"startDate\":\"2019-01-02T09:07:30.1+08:00\",\"endDate\":\"2019-05-25T23:59:00+08:00\",\"publish\":true,\"parentID\":\"087b320f-aeb8-4cb9-92d9-59a0f0845043\",\"resourceID\":\"00000000-0000-0000-0000-000000000000\",\"access\":{\"access_Full\":false,\"access_Read\":true,\"access_Create\":false,\"access_Update\":false,\"access_Delete\":false,\"access_Settings_Read\":false,\"access_Settings_Update\":false},\"courseName\":\"Programming Methodology II\",\"facultyCode\":\"39\",\"departmentCode\":\"252\",\"term\":\"1820\",\"acadCareer\":\"UGRD\",\"courseSearchable\":true,\"allowAnonFeedback\":\"N\",\"displayLibGuide\":true,\"copyFromID\":\"00000000-0000-0000-0000-000000000000\",\"l3\":false,\"enableLearningFlow\":true,\"usedNusCalendar\":false,\"isCorporateCourse\":false}]}"
    cond do
      path == "profile" -> 
        json conn, profile
      path == "modules" ->
        json conn, modules
    end
  end

  def get_auth(username, password) do
    {:ok, auth} = Fluminus.Authorization.jwt(username, password)
    auth
  end

  def raw_api_call(%Fluminus.Authorization{jwt: jwt}, path) do
    headers = []
    headers =
      headers ++
        [
          {"Authorization", "Bearer #{jwt}"},
          {"Ocp-Apim-Subscription-Key", "6963c200ca9440de8fa1eede730d8f7e"},
          {"Content-Type", "application/json"}
        ]
    uri = "https://luminus.azure-api.net"|> URI.merge(path) |> URI.to_string()
    Fluminus.HTTPClient.request(%Fluminus.HTTPClient{}, 
                                :get, 
                                uri,
                                "",
                                headers)
  end

end
