// USER TABLE
const String userTable = "user";
const String userIdColumn = "id";
const String userEmailColumn = "email";
const String userPhoneColumn = "phone";
const String userPhotoColumn = "photo";
const String userPlatformColumn = "platform";
const String userFirstNameColumn = "first_name";
const String userLastNameColumn = "last_name";
const String userBirthdateColumn = "birthdate";
const String userGenderColumn = "gender";
const String userCpfColumn = "cpf";
const String userCreaColumn = "crea";
const String userCreaStateColumn = "crea_state";
const String userClassColumn = "userclass";
const String userIsAdminColumn = "is_admin";
const String userAcceptedTermsColumn = "accepted_terms";

// AUTH USER
const String authUserTable = "auth_user";
const String authIdColumn = "id";
const String authTokenUserIdColumn = "user_id";
const String authTokenColumn = "token";

// CUSTOM USER ADDRESS TABLE
const String userAddressTable = "user_address";
const String userAddressIdColumn = "id";
const String userAddressCepColumn = "cep";
const String userAddressCityColumn = "city";
const String userAddressStateColumn = "state";
const String userAddressIsFarmColumn = "isFarm";
const String userAddressStreetColumn = "street";
const String userAddressNumberColumn = "number";
const String userAddressNeighborhoodColumn = "neighborhood";
const String userAddressComplementColumn = "complement";

// CUSTOM LEVEL USER TABLE
const String customLevelUserTable = "custom_level_user";
const String customLevelUserIdColumn = "id";
const String customLevelUserPrescriptionsMadeColumn = "prescriptions_made";
const String customLevelUserReportsMadeColumn = "reports_made";
const String customLevelUserLastRenovationColumn = "last_renovation";
const String customLevelUserCurrentPeriodStartColumn = "period_start";
const String customLevelUsercurrentPeriodEndColumn = "period_end";

// LEVEL TABLE
const String userLevelTable = "user_level";
const String userLevelIdColumn = "id";
const String userLevelRankColumn = "rank";
const String userLevelQuantPrescriptionColumn = "prescription_quantity";
const String userLevelQuantReportColumn = "report_quantity";
const String userLevelCompanyLogoColumn = "company_logo";
const String userLevelQuestionAnswerColumn = "question_answer";
const String userLevelAnswerEstimateColumn = "answer_estimate";
const String userLevelOfferColumn = "offer";
const String userLevelAdvancedReportColumn = "advanced_report";
const String userLevelNdviColumn = "ndvi";
const String userLevelIsActiveColumn = "is_active";
const String userLevelPlanIdColumn = 'plan_id';
const String userLevelPriceColumn = "price";

// NATURAL ENEMY TABLE
const String naturalEnemiesTable = "naturalEnemies";
const String naturalEnemiesIdColumn = "id";
const String naturalEnemiesNameColumn = "name";
const String naturalEnemiesScientificNameColumn = "scientificName";

// PRODUCT TABLE
const String productTable = "product";
const String productIdColumn = "id";
const String productNameColumn = "productName";
const String productActivePrincipleColumn = "activePrinciple";

// CONTAMINATION TABLE
const String contaminationTable = "contamination";
const String contaminationIdColumn = "id";
const String contaminationNameColumn = "name";
const String contaminationScientificNameColumn = "scientificName";
const String contaminationTypeColumn = "contaminationType";

// CULTURE TABLE
const String cultureTable = "culture";
const String cultureIdColumn = "id";
const String cultureNameColumn = "name";

// PRODUCER TABLE
const String producerTable = "producer";
const String producerIdColumn = "id";
const String producerIsCnpjColumn = "is_cnpj";
const String producerCnpjCpfColumn = "cnpj_cpf";
const String producerFirstNameColumn = "first_name";
const String producerGenderColumn = "gender";
const String producerLastNameColumn = "last_name";
const String producerCreatedAtColumn = "created_at";
const String producerUpdatedAtColumn = "updated_at";
const String producerUserPlatformColumn = "user_platform";
const String producerAgronomistIdColumn = "agronomist_id";
const String producerIsActiveColumn = "is_active";
const String producerIsSyncColumn = "is_sync";
const String producerIsUpdatedColumn = "is_updated";

// FARM TABLE
const String farmTable = "farm";
const String farmIdColumn = "id";
const String farmNameColumn = "name";
const String farmStateColumn = "state";
const String farmCityColumn = "city";
const String farmHectaresColumn = "hectares";
const String farmCreatedAtColumn = "created_at";
const String farmUpdatedAtColumn = "updated_at";
const String farmActiveColumn = "active";
const String farmLocationColumn = "location";
const String farmNeighborhoodColumn = "neighborhood";
const String farmProducerIdColumn = "producer_id";
const String farmUserIdColumn = "user_id";
const String farmIsSyncColumn = "is_sync";
const String farmIsUpdatedColumn = "is_updated";

// FIELD TABLE
const String fieldTable = "field";
const String fieldIdColumn = "id";
const String fieldFarmIdColumn = "farm_id";
const String fieldNameColumn = "name";
const String fieldHectareColumn = "hectare";
const String fieldLatitudeColumn = "latitude";
const String fieldLongitudeColumn = "longitude";
const String fieldCultureIdColumn = "culture_id";
const String fieldPlanningDateColumn = "planning_date";
const String fieldSoilTypeIdColumn = "soil";
const String fieldActiveColumn = "active";
const String fieldSyncColumn = "is_sync";
const String fieldUpdatedColumn = "is_updated";

// FIELD MAP TABLE
const String fieldMapTable = "field_map";
const String fieldMapIdColumn = "id";
const String fieldMapLatitudeColumn = "latitude";
const String fieldMapLongitudeColumn = "longitude";
const String fieldMapFieldColumn = "field_id";

// REPORT TABLE
const String reportTable = "report";
const String reportIdColumn = "id";
const String reportFarmNameColumn = "farm_name";
const String reportFarmOwnerColumn = "farm_owner";
const String reportDateColumn = "date";
const String reportLatitudeColumn = "latitude";
const String reportLongitudeColumn = "longitude";
const String reportDescriptionColumn = "report";
const String reportUrlPdfColumn = "url_pdf";
const String reportUserIdColumn = "user_id";
const String reportIsSyncColumn = "is_sync";
const String reportIsUpdatedColumn = "is_updated";
const String reportCreatedAtColumn = "created_at";
const String reportUpdatedAtColumn = "updated_at";

// REPORT GALLERY TABLE
const String reportGalleryTable = "galleries";
const String reportGalleryImageIdColumn = "id";
const String reportGalleryUrlImageColumn = "url_image";
const String reportGalleryCategoryImageColumn = "category";
const String reportGalleryReportIdColumn = "report_id";

// REPORT HANDLING TABLE
const String reportHandlingTable = "handling";
const String reportHandlingIdColumn = "id";
const String reportHandlingNoteColumn = "note";
const String reportHandlingRankColumn = "rank";
const String reportHandlingIdReportColumn = "id_report";

// REPORT FERTILITY TABLE
const String reportFertilityTable = "fertility";
const String reportFertilityIdColumn = "id";
const String reportFertilityNoteColumn = "note";
const String reportFertilityRankColumn = "rank";
const String reportFertilityIdReportColumn = "id_report";

// REPORT PLANT HEALTH TABLE
const String reportHealthTable = "plant_health";
const String reportHealthIdColumn = "id";
const String reportHealthNoteColumn = "note";
const String reportHealthRankColumn = "rank";
const String reportHealthIdReportColumn = "id_report";

// ADV REPORT TABLE
const String advReportTable = "adv_report";
const String advReportIdColumn = "id";
const String advReportProducerIdColumn = "producerId";
const String advReportIsActiveColumn = "isActive";
const String advReportIsSyncColumn = "isSync";
const String advReportIsEditedColumn = "isEdited";
const String advReportUuidColumn = "uuid";
const String advReportUrlPdfColumn = "urlPdf";
const String advReportCreatedAtColumn = "createdAt";
const String advReportUpdatedAtColumn = "updatedAt";

// ADV REPORT - RECORDS
const String advReportRecordsTable = "adv_report_records";
const String advReportRecordsIdColumn = "id";
const String advReportRecordsUuidColumn = "uuid";
const String advReportRecordsUrlImageColumn = "urlImage";
const String advReportRecordsAssetImageColumn = "assetImage";
const String advReportRecordsCreatedAtColumn = "createdAt";
const String advReportRecordsPhotoDateColumn = "photoDate";
const String advReportRecordsLatitudeColumn = "latitude";
const String advReportRecordsLongitudeColumn = "longitude";
const String advReportRecordsIsEditedColumn = "isEdited";
const String advReportRecordsObsColumn = "obs";
const String advReportRecordsFkReportColumn = "fk_report_id";
const String advReportRecordsFkFarmReportColumn = "fk_farm_report_id";
const String advReportRecordsFkFieldReportColumn = "fk_field_report_id";
