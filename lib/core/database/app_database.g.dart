// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String userName;
  const UserData({required this.id, required this.userName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_name'] = Variable<String>(userName);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(id: Value(id), userName: Value(userName));
  }

  factory UserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
    };
  }

  UserData copyWith({int? id, String? userName}) =>
      UserData(id: id ?? this.id, userName: userName ?? this.userName);
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      userName: data.userName.present ? data.userName.value : this.userName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('userName: $userName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.userName == this.userName);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> userName;
  const UserCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    required String userName,
  }) : userName = Value(userName);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? userName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
    });
  }

  UserCompanion copyWith({Value<int>? id, Value<String>? userName}) {
    return UserCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName')
          ..write(')'))
        .toString();
  }
}

class $ExerciseTable extends Exercise
    with TableInfo<$ExerciseTable, ExerciseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscularGroupMeta = const VerificationMeta(
    'muscularGroup',
  );
  @override
  late final GeneratedColumn<String> muscularGroup = GeneratedColumn<String>(
    'muscular_group',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseName, muscularGroup];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('muscular_group')) {
      context.handle(
        _muscularGroupMeta,
        muscularGroup.isAcceptableOrUnknown(
          data['muscular_group']!,
          _muscularGroupMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_muscularGroupMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      muscularGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscular_group'],
      )!,
    );
  }

  @override
  $ExerciseTable createAlias(String alias) {
    return $ExerciseTable(attachedDatabase, alias);
  }
}

class ExerciseData extends DataClass implements Insertable<ExerciseData> {
  final int id;
  final String exerciseName;
  final String muscularGroup;
  const ExerciseData({
    required this.id,
    required this.exerciseName,
    required this.muscularGroup,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['muscular_group'] = Variable<String>(muscularGroup);
    return map;
  }

  ExerciseCompanion toCompanion(bool nullToAbsent) {
    return ExerciseCompanion(
      id: Value(id),
      exerciseName: Value(exerciseName),
      muscularGroup: Value(muscularGroup),
    );
  }

  factory ExerciseData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseData(
      id: serializer.fromJson<int>(json['id']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      muscularGroup: serializer.fromJson<String>(json['muscularGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'muscularGroup': serializer.toJson<String>(muscularGroup),
    };
  }

  ExerciseData copyWith({
    int? id,
    String? exerciseName,
    String? muscularGroup,
  }) => ExerciseData(
    id: id ?? this.id,
    exerciseName: exerciseName ?? this.exerciseName,
    muscularGroup: muscularGroup ?? this.muscularGroup,
  );
  ExerciseData copyWithCompanion(ExerciseCompanion data) {
    return ExerciseData(
      id: data.id.present ? data.id.value : this.id,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      muscularGroup: data.muscularGroup.present
          ? data.muscularGroup.value
          : this.muscularGroup,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseData(')
          ..write('id: $id, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('muscularGroup: $muscularGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseName, muscularGroup);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseData &&
          other.id == this.id &&
          other.exerciseName == this.exerciseName &&
          other.muscularGroup == this.muscularGroup);
}

class ExerciseCompanion extends UpdateCompanion<ExerciseData> {
  final Value<int> id;
  final Value<String> exerciseName;
  final Value<String> muscularGroup;
  const ExerciseCompanion({
    this.id = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.muscularGroup = const Value.absent(),
  });
  ExerciseCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseName,
    required String muscularGroup,
  }) : exerciseName = Value(exerciseName),
       muscularGroup = Value(muscularGroup);
  static Insertable<ExerciseData> custom({
    Expression<int>? id,
    Expression<String>? exerciseName,
    Expression<String>? muscularGroup,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (muscularGroup != null) 'muscular_group': muscularGroup,
    });
  }

  ExerciseCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseName,
    Value<String>? muscularGroup,
  }) {
    return ExerciseCompanion(
      id: id ?? this.id,
      exerciseName: exerciseName ?? this.exerciseName,
      muscularGroup: muscularGroup ?? this.muscularGroup,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (muscularGroup.present) {
      map['muscular_group'] = Variable<String>(muscularGroup.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCompanion(')
          ..write('id: $id, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('muscularGroup: $muscularGroup')
          ..write(')'))
        .toString();
  }
}

class $RoutineTable extends Routine with TableInfo<$RoutineTable, RoutineData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user (id)',
    ),
  );
  static const VerificationMeta _routineNameMeta = const VerificationMeta(
    'routineName',
  );
  @override
  late final GeneratedColumn<String> routineName = GeneratedColumn<String>(
    'routine_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayWeekMeta = const VerificationMeta(
    'dayWeek',
  );
  @override
  late final GeneratedColumn<String> dayWeek = GeneratedColumn<String>(
    'day_week',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    routineName,
    dayWeek,
    creationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('routine_name')) {
      context.handle(
        _routineNameMeta,
        routineName.isAcceptableOrUnknown(
          data['routine_name']!,
          _routineNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_routineNameMeta);
    }
    if (data.containsKey('day_week')) {
      context.handle(
        _dayWeekMeta,
        dayWeek.isAcceptableOrUnknown(data['day_week']!, _dayWeekMeta),
      );
    } else if (isInserting) {
      context.missing(_dayWeekMeta);
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      routineName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_name'],
      )!,
      dayWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_week'],
      )!,
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
    );
  }

  @override
  $RoutineTable createAlias(String alias) {
    return $RoutineTable(attachedDatabase, alias);
  }
}

class RoutineData extends DataClass implements Insertable<RoutineData> {
  final int id;
  final int userId;
  final String routineName;
  final String dayWeek;
  final DateTime creationDate;
  const RoutineData({
    required this.id,
    required this.userId,
    required this.routineName,
    required this.dayWeek,
    required this.creationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['routine_name'] = Variable<String>(routineName);
    map['day_week'] = Variable<String>(dayWeek);
    map['creation_date'] = Variable<DateTime>(creationDate);
    return map;
  }

  RoutineCompanion toCompanion(bool nullToAbsent) {
    return RoutineCompanion(
      id: Value(id),
      userId: Value(userId),
      routineName: Value(routineName),
      dayWeek: Value(dayWeek),
      creationDate: Value(creationDate),
    );
  }

  factory RoutineData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      routineName: serializer.fromJson<String>(json['routineName']),
      dayWeek: serializer.fromJson<String>(json['dayWeek']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'routineName': serializer.toJson<String>(routineName),
      'dayWeek': serializer.toJson<String>(dayWeek),
      'creationDate': serializer.toJson<DateTime>(creationDate),
    };
  }

  RoutineData copyWith({
    int? id,
    int? userId,
    String? routineName,
    String? dayWeek,
    DateTime? creationDate,
  }) => RoutineData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    routineName: routineName ?? this.routineName,
    dayWeek: dayWeek ?? this.dayWeek,
    creationDate: creationDate ?? this.creationDate,
  );
  RoutineData copyWithCompanion(RoutineCompanion data) {
    return RoutineData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      routineName: data.routineName.present
          ? data.routineName.value
          : this.routineName,
      dayWeek: data.dayWeek.present ? data.dayWeek.value : this.dayWeek,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('routineName: $routineName, ')
          ..write('dayWeek: $dayWeek, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, routineName, dayWeek, creationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.routineName == this.routineName &&
          other.dayWeek == this.dayWeek &&
          other.creationDate == this.creationDate);
}

class RoutineCompanion extends UpdateCompanion<RoutineData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> routineName;
  final Value<String> dayWeek;
  final Value<DateTime> creationDate;
  const RoutineCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.routineName = const Value.absent(),
    this.dayWeek = const Value.absent(),
    this.creationDate = const Value.absent(),
  });
  RoutineCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String routineName,
    required String dayWeek,
    required DateTime creationDate,
  }) : userId = Value(userId),
       routineName = Value(routineName),
       dayWeek = Value(dayWeek),
       creationDate = Value(creationDate);
  static Insertable<RoutineData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? routineName,
    Expression<String>? dayWeek,
    Expression<DateTime>? creationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (routineName != null) 'routine_name': routineName,
      if (dayWeek != null) 'day_week': dayWeek,
      if (creationDate != null) 'creation_date': creationDate,
    });
  }

  RoutineCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? routineName,
    Value<String>? dayWeek,
    Value<DateTime>? creationDate,
  }) {
    return RoutineCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      routineName: routineName ?? this.routineName,
      dayWeek: dayWeek ?? this.dayWeek,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (routineName.present) {
      map['routine_name'] = Variable<String>(routineName.value);
    }
    if (dayWeek.present) {
      map['day_week'] = Variable<String>(dayWeek.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('routineName: $routineName, ')
          ..write('dayWeek: $dayWeek, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }
}

class $RoutineDetailTable extends RoutineDetail
    with TableInfo<$RoutineDetailTable, RoutineDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routine (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise (id)',
    ),
  );
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<int> series = GeneratedColumn<int>(
    'series',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialWeightMeta = const VerificationMeta(
    'initialWeight',
  );
  @override
  late final GeneratedColumn<double> initialWeight = GeneratedColumn<double>(
    'initial_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    exerciseId,
    series,
    repetitions,
    initialWeight,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_detail';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineDetailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesMeta);
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repetitionsMeta);
    }
    if (data.containsKey('initial_weight')) {
      context.handle(
        _initialWeightMeta,
        initialWeight.isAcceptableOrUnknown(
          data['initial_weight']!,
          _initialWeightMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialWeightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineDetailData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      initialWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_weight'],
      )!,
    );
  }

  @override
  $RoutineDetailTable createAlias(String alias) {
    return $RoutineDetailTable(attachedDatabase, alias);
  }
}

class RoutineDetailData extends DataClass
    implements Insertable<RoutineDetailData> {
  final int id;
  final int routineId;
  final int exerciseId;
  final int series;
  final int repetitions;
  final double initialWeight;
  const RoutineDetailData({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    required this.series,
    required this.repetitions,
    required this.initialWeight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['routine_id'] = Variable<int>(routineId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['series'] = Variable<int>(series);
    map['repetitions'] = Variable<int>(repetitions);
    map['initial_weight'] = Variable<double>(initialWeight);
    return map;
  }

  RoutineDetailCompanion toCompanion(bool nullToAbsent) {
    return RoutineDetailCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      series: Value(series),
      repetitions: Value(repetitions),
      initialWeight: Value(initialWeight),
    );
  }

  factory RoutineDetailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineDetailData(
      id: serializer.fromJson<int>(json['id']),
      routineId: serializer.fromJson<int>(json['routineId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      series: serializer.fromJson<int>(json['series']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      initialWeight: serializer.fromJson<double>(json['initialWeight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routineId': serializer.toJson<int>(routineId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'series': serializer.toJson<int>(series),
      'repetitions': serializer.toJson<int>(repetitions),
      'initialWeight': serializer.toJson<double>(initialWeight),
    };
  }

  RoutineDetailData copyWith({
    int? id,
    int? routineId,
    int? exerciseId,
    int? series,
    int? repetitions,
    double? initialWeight,
  }) => RoutineDetailData(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    exerciseId: exerciseId ?? this.exerciseId,
    series: series ?? this.series,
    repetitions: repetitions ?? this.repetitions,
    initialWeight: initialWeight ?? this.initialWeight,
  );
  RoutineDetailData copyWithCompanion(RoutineDetailCompanion data) {
    return RoutineDetailData(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      series: data.series.present ? data.series.value : this.series,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      initialWeight: data.initialWeight.present
          ? data.initialWeight.value
          : this.initialWeight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineDetailData(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('series: $series, ')
          ..write('repetitions: $repetitions, ')
          ..write('initialWeight: $initialWeight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    exerciseId,
    series,
    repetitions,
    initialWeight,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineDetailData &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.series == this.series &&
          other.repetitions == this.repetitions &&
          other.initialWeight == this.initialWeight);
}

class RoutineDetailCompanion extends UpdateCompanion<RoutineDetailData> {
  final Value<int> id;
  final Value<int> routineId;
  final Value<int> exerciseId;
  final Value<int> series;
  final Value<int> repetitions;
  final Value<double> initialWeight;
  const RoutineDetailCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.series = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.initialWeight = const Value.absent(),
  });
  RoutineDetailCompanion.insert({
    this.id = const Value.absent(),
    required int routineId,
    required int exerciseId,
    required int series,
    required int repetitions,
    required double initialWeight,
  }) : routineId = Value(routineId),
       exerciseId = Value(exerciseId),
       series = Value(series),
       repetitions = Value(repetitions),
       initialWeight = Value(initialWeight);
  static Insertable<RoutineDetailData> custom({
    Expression<int>? id,
    Expression<int>? routineId,
    Expression<int>? exerciseId,
    Expression<int>? series,
    Expression<int>? repetitions,
    Expression<double>? initialWeight,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (series != null) 'series': series,
      if (repetitions != null) 'repetitions': repetitions,
      if (initialWeight != null) 'initial_weight': initialWeight,
    });
  }

  RoutineDetailCompanion copyWith({
    Value<int>? id,
    Value<int>? routineId,
    Value<int>? exerciseId,
    Value<int>? series,
    Value<int>? repetitions,
    Value<double>? initialWeight,
  }) {
    return RoutineDetailCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      series: series ?? this.series,
      repetitions: repetitions ?? this.repetitions,
      initialWeight: initialWeight ?? this.initialWeight,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (series.present) {
      map['series'] = Variable<int>(series.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (initialWeight.present) {
      map['initial_weight'] = Variable<double>(initialWeight.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineDetailCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('series: $series, ')
          ..write('repetitions: $repetitions, ')
          ..write('initialWeight: $initialWeight')
          ..write(')'))
        .toString();
  }
}

class $TrainingTable extends Training
    with TableInfo<$TrainingTable, TrainingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user (id)',
    ),
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<int> routineId = GeneratedColumn<int>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routine (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    routineId,
    date,
    duration,
    calories,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}routine_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories'],
      )!,
    );
  }

  @override
  $TrainingTable createAlias(String alias) {
    return $TrainingTable(attachedDatabase, alias);
  }
}

class TrainingData extends DataClass implements Insertable<TrainingData> {
  final int id;
  final int userId;
  final int routineId;
  final DateTime date;
  final int duration;
  final int calories;
  const TrainingData({
    required this.id,
    required this.userId,
    required this.routineId,
    required this.date,
    required this.duration,
    required this.calories,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['routine_id'] = Variable<int>(routineId);
    map['date'] = Variable<DateTime>(date);
    map['duration'] = Variable<int>(duration);
    map['calories'] = Variable<int>(calories);
    return map;
  }

  TrainingCompanion toCompanion(bool nullToAbsent) {
    return TrainingCompanion(
      id: Value(id),
      userId: Value(userId),
      routineId: Value(routineId),
      date: Value(date),
      duration: Value(duration),
      calories: Value(calories),
    );
  }

  factory TrainingData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      routineId: serializer.fromJson<int>(json['routineId']),
      date: serializer.fromJson<DateTime>(json['date']),
      duration: serializer.fromJson<int>(json['duration']),
      calories: serializer.fromJson<int>(json['calories']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'routineId': serializer.toJson<int>(routineId),
      'date': serializer.toJson<DateTime>(date),
      'duration': serializer.toJson<int>(duration),
      'calories': serializer.toJson<int>(calories),
    };
  }

  TrainingData copyWith({
    int? id,
    int? userId,
    int? routineId,
    DateTime? date,
    int? duration,
    int? calories,
  }) => TrainingData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    routineId: routineId ?? this.routineId,
    date: date ?? this.date,
    duration: duration ?? this.duration,
    calories: calories ?? this.calories,
  );
  TrainingData copyWithCompanion(TrainingCompanion data) {
    return TrainingData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      date: data.date.present ? data.date.value : this.date,
      duration: data.duration.present ? data.duration.value : this.duration,
      calories: data.calories.present ? data.calories.value : this.calories,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('routineId: $routineId, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('calories: $calories')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, routineId, date, duration, calories);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.routineId == this.routineId &&
          other.date == this.date &&
          other.duration == this.duration &&
          other.calories == this.calories);
}

class TrainingCompanion extends UpdateCompanion<TrainingData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> routineId;
  final Value<DateTime> date;
  final Value<int> duration;
  final Value<int> calories;
  const TrainingCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.routineId = const Value.absent(),
    this.date = const Value.absent(),
    this.duration = const Value.absent(),
    this.calories = const Value.absent(),
  });
  TrainingCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int routineId,
    required DateTime date,
    required int duration,
    required int calories,
  }) : userId = Value(userId),
       routineId = Value(routineId),
       date = Value(date),
       duration = Value(duration),
       calories = Value(calories);
  static Insertable<TrainingData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? routineId,
    Expression<DateTime>? date,
    Expression<int>? duration,
    Expression<int>? calories,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (routineId != null) 'routine_id': routineId,
      if (date != null) 'date': date,
      if (duration != null) 'duration': duration,
      if (calories != null) 'calories': calories,
    });
  }

  TrainingCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? routineId,
    Value<DateTime>? date,
    Value<int>? duration,
    Value<int>? calories,
  }) {
    return TrainingCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      routineId: routineId ?? this.routineId,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      calories: calories ?? this.calories,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<int>(routineId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('routineId: $routineId, ')
          ..write('date: $date, ')
          ..write('duration: $duration, ')
          ..write('calories: $calories')
          ..write(')'))
        .toString();
  }
}

class $TrainingDetailTable extends TrainingDetail
    with TableInfo<$TrainingDetailTable, TrainingDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trainingIdMeta = const VerificationMeta(
    'trainingId',
  );
  @override
  late final GeneratedColumn<int> trainingId = GeneratedColumn<int>(
    'training_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES training (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise (id)',
    ),
  );
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<int> series = GeneratedColumn<int>(
    'series',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usedWeightMeta = const VerificationMeta(
    'usedWeight',
  );
  @override
  late final GeneratedColumn<double> usedWeight = GeneratedColumn<double>(
    'used_weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trainingId,
    exerciseId,
    series,
    repetitions,
    usedWeight,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_detail';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingDetailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('training_id')) {
      context.handle(
        _trainingIdMeta,
        trainingId.isAcceptableOrUnknown(data['training_id']!, _trainingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trainingIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesMeta);
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repetitionsMeta);
    }
    if (data.containsKey('used_weight')) {
      context.handle(
        _usedWeightMeta,
        usedWeight.isAcceptableOrUnknown(data['used_weight']!, _usedWeightMeta),
      );
    } else if (isInserting) {
      context.missing(_usedWeightMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrainingDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingDetailData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trainingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}training_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      usedWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}used_weight'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
    );
  }

  @override
  $TrainingDetailTable createAlias(String alias) {
    return $TrainingDetailTable(attachedDatabase, alias);
  }
}

class TrainingDetailData extends DataClass
    implements Insertable<TrainingDetailData> {
  final int id;
  final int trainingId;
  final int exerciseId;
  final int series;
  final int repetitions;
  final double usedWeight;
  final bool completed;
  const TrainingDetailData({
    required this.id,
    required this.trainingId,
    required this.exerciseId,
    required this.series,
    required this.repetitions,
    required this.usedWeight,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['training_id'] = Variable<int>(trainingId);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['series'] = Variable<int>(series);
    map['repetitions'] = Variable<int>(repetitions);
    map['used_weight'] = Variable<double>(usedWeight);
    map['completed'] = Variable<bool>(completed);
    return map;
  }

  TrainingDetailCompanion toCompanion(bool nullToAbsent) {
    return TrainingDetailCompanion(
      id: Value(id),
      trainingId: Value(trainingId),
      exerciseId: Value(exerciseId),
      series: Value(series),
      repetitions: Value(repetitions),
      usedWeight: Value(usedWeight),
      completed: Value(completed),
    );
  }

  factory TrainingDetailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingDetailData(
      id: serializer.fromJson<int>(json['id']),
      trainingId: serializer.fromJson<int>(json['trainingId']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      series: serializer.fromJson<int>(json['series']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      usedWeight: serializer.fromJson<double>(json['usedWeight']),
      completed: serializer.fromJson<bool>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trainingId': serializer.toJson<int>(trainingId),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'series': serializer.toJson<int>(series),
      'repetitions': serializer.toJson<int>(repetitions),
      'usedWeight': serializer.toJson<double>(usedWeight),
      'completed': serializer.toJson<bool>(completed),
    };
  }

  TrainingDetailData copyWith({
    int? id,
    int? trainingId,
    int? exerciseId,
    int? series,
    int? repetitions,
    double? usedWeight,
    bool? completed,
  }) => TrainingDetailData(
    id: id ?? this.id,
    trainingId: trainingId ?? this.trainingId,
    exerciseId: exerciseId ?? this.exerciseId,
    series: series ?? this.series,
    repetitions: repetitions ?? this.repetitions,
    usedWeight: usedWeight ?? this.usedWeight,
    completed: completed ?? this.completed,
  );
  TrainingDetailData copyWithCompanion(TrainingDetailCompanion data) {
    return TrainingDetailData(
      id: data.id.present ? data.id.value : this.id,
      trainingId: data.trainingId.present
          ? data.trainingId.value
          : this.trainingId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      series: data.series.present ? data.series.value : this.series,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      usedWeight: data.usedWeight.present
          ? data.usedWeight.value
          : this.usedWeight,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingDetailData(')
          ..write('id: $id, ')
          ..write('trainingId: $trainingId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('series: $series, ')
          ..write('repetitions: $repetitions, ')
          ..write('usedWeight: $usedWeight, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    trainingId,
    exerciseId,
    series,
    repetitions,
    usedWeight,
    completed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingDetailData &&
          other.id == this.id &&
          other.trainingId == this.trainingId &&
          other.exerciseId == this.exerciseId &&
          other.series == this.series &&
          other.repetitions == this.repetitions &&
          other.usedWeight == this.usedWeight &&
          other.completed == this.completed);
}

class TrainingDetailCompanion extends UpdateCompanion<TrainingDetailData> {
  final Value<int> id;
  final Value<int> trainingId;
  final Value<int> exerciseId;
  final Value<int> series;
  final Value<int> repetitions;
  final Value<double> usedWeight;
  final Value<bool> completed;
  const TrainingDetailCompanion({
    this.id = const Value.absent(),
    this.trainingId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.series = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.usedWeight = const Value.absent(),
    this.completed = const Value.absent(),
  });
  TrainingDetailCompanion.insert({
    this.id = const Value.absent(),
    required int trainingId,
    required int exerciseId,
    required int series,
    required int repetitions,
    required double usedWeight,
    required bool completed,
  }) : trainingId = Value(trainingId),
       exerciseId = Value(exerciseId),
       series = Value(series),
       repetitions = Value(repetitions),
       usedWeight = Value(usedWeight),
       completed = Value(completed);
  static Insertable<TrainingDetailData> custom({
    Expression<int>? id,
    Expression<int>? trainingId,
    Expression<int>? exerciseId,
    Expression<int>? series,
    Expression<int>? repetitions,
    Expression<double>? usedWeight,
    Expression<bool>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trainingId != null) 'training_id': trainingId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (series != null) 'series': series,
      if (repetitions != null) 'repetitions': repetitions,
      if (usedWeight != null) 'used_weight': usedWeight,
      if (completed != null) 'completed': completed,
    });
  }

  TrainingDetailCompanion copyWith({
    Value<int>? id,
    Value<int>? trainingId,
    Value<int>? exerciseId,
    Value<int>? series,
    Value<int>? repetitions,
    Value<double>? usedWeight,
    Value<bool>? completed,
  }) {
    return TrainingDetailCompanion(
      id: id ?? this.id,
      trainingId: trainingId ?? this.trainingId,
      exerciseId: exerciseId ?? this.exerciseId,
      series: series ?? this.series,
      repetitions: repetitions ?? this.repetitions,
      usedWeight: usedWeight ?? this.usedWeight,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trainingId.present) {
      map['training_id'] = Variable<int>(trainingId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (series.present) {
      map['series'] = Variable<int>(series.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (usedWeight.present) {
      map['used_weight'] = Variable<double>(usedWeight.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingDetailCompanion(')
          ..write('id: $id, ')
          ..write('trainingId: $trainingId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('series: $series, ')
          ..write('repetitions: $repetitions, ')
          ..write('usedWeight: $usedWeight, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTable user = $UserTable(this);
  late final $ExerciseTable exercise = $ExerciseTable(this);
  late final $RoutineTable routine = $RoutineTable(this);
  late final $RoutineDetailTable routineDetail = $RoutineDetailTable(this);
  late final $TrainingTable training = $TrainingTable(this);
  late final $TrainingDetailTable trainingDetail = $TrainingDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    user,
    exercise,
    routine,
    routineDetail,
    training,
    trainingDetail,
  ];
}

typedef $$UserTableCreateCompanionBuilder =
    UserCompanion Function({Value<int> id, required String userName});
typedef $$UserTableUpdateCompanionBuilder =
    UserCompanion Function({Value<int> id, Value<String> userName});

final class $$UserTableReferences
    extends BaseReferences<_$AppDatabase, $UserTable, UserData> {
  $$UserTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutineTable, List<RoutineData>>
  _routineRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routine,
    aliasName: $_aliasNameGenerator(db.user.id, db.routine.userId),
  );

  $$RoutineTableProcessedTableManager get routineRefs {
    final manager = $$RoutineTableTableManager(
      $_db,
      $_db.routine,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrainingTable, List<TrainingData>>
  _trainingRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.training,
    aliasName: $_aliasNameGenerator(db.user.id, db.training.userId),
  );

  $$TrainingTableProcessedTableManager get trainingRefs {
    final manager = $$TrainingTableTableManager(
      $_db,
      $_db.training,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trainingRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserTableFilterComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineRefs(
    Expression<bool> Function($$RoutineTableFilterComposer f) f,
  ) {
    final $$RoutineTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableFilterComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trainingRefs(
    Expression<bool> Function($$TrainingTableFilterComposer f) f,
  ) {
    final $$TrainingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableFilterComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserTableOrderingComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  Expression<T> routineRefs<T extends Object>(
    Expression<T> Function($$RoutineTableAnnotationComposer a) f,
  ) {
    final $$RoutineTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableAnnotationComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trainingRefs<T extends Object>(
    Expression<T> Function($$TrainingTableAnnotationComposer a) f,
  ) {
    final $$TrainingTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableAnnotationComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTable,
          UserData,
          $$UserTableFilterComposer,
          $$UserTableOrderingComposer,
          $$UserTableAnnotationComposer,
          $$UserTableCreateCompanionBuilder,
          $$UserTableUpdateCompanionBuilder,
          (UserData, $$UserTableReferences),
          UserData,
          PrefetchHooks Function({bool routineRefs, bool trainingRefs})
        > {
  $$UserTableTableManager(_$AppDatabase db, $UserTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
              }) => UserCompanion(id: id, userName: userName),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userName,
              }) => UserCompanion.insert(id: id, userName: userName),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UserTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({routineRefs = false, trainingRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (routineRefs) db.routine,
                if (trainingRefs) db.training,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (routineRefs)
                    await $_getPrefetchedData<
                      UserData,
                      $UserTable,
                      RoutineData
                    >(
                      currentTable: table,
                      referencedTable: $$UserTableReferences._routineRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UserTableReferences(db, table, p0).routineRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                  if (trainingRefs)
                    await $_getPrefetchedData<
                      UserData,
                      $UserTable,
                      TrainingData
                    >(
                      currentTable: table,
                      referencedTable: $$UserTableReferences._trainingRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UserTableReferences(db, table, p0).trainingRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTable,
      UserData,
      $$UserTableFilterComposer,
      $$UserTableOrderingComposer,
      $$UserTableAnnotationComposer,
      $$UserTableCreateCompanionBuilder,
      $$UserTableUpdateCompanionBuilder,
      (UserData, $$UserTableReferences),
      UserData,
      PrefetchHooks Function({bool routineRefs, bool trainingRefs})
    >;
typedef $$ExerciseTableCreateCompanionBuilder =
    ExerciseCompanion Function({
      Value<int> id,
      required String exerciseName,
      required String muscularGroup,
    });
typedef $$ExerciseTableUpdateCompanionBuilder =
    ExerciseCompanion Function({
      Value<int> id,
      Value<String> exerciseName,
      Value<String> muscularGroup,
    });

final class $$ExerciseTableReferences
    extends BaseReferences<_$AppDatabase, $ExerciseTable, ExerciseData> {
  $$ExerciseTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoutineDetailTable, List<RoutineDetailData>>
  _routineDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineDetail,
    aliasName: $_aliasNameGenerator(
      db.exercise.id,
      db.routineDetail.exerciseId,
    ),
  );

  $$RoutineDetailTableProcessedTableManager get routineDetailRefs {
    final manager = $$RoutineDetailTableTableManager(
      $_db,
      $_db.routineDetail,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrainingDetailTable, List<TrainingDetailData>>
  _trainingDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trainingDetail,
    aliasName: $_aliasNameGenerator(
      db.exercise.id,
      db.trainingDetail.exerciseId,
    ),
  );

  $$TrainingDetailTableProcessedTableManager get trainingDetailRefs {
    final manager = $$TrainingDetailTableTableManager(
      $_db,
      $_db.trainingDetail,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trainingDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExerciseTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseTable> {
  $$ExerciseTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscularGroup => $composableBuilder(
    column: $table.muscularGroup,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> routineDetailRefs(
    Expression<bool> Function($$RoutineDetailTableFilterComposer f) f,
  ) {
    final $$RoutineDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineDetail,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineDetailTableFilterComposer(
            $db: $db,
            $table: $db.routineDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trainingDetailRefs(
    Expression<bool> Function($$TrainingDetailTableFilterComposer f) f,
  ) {
    final $$TrainingDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingDetail,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingDetailTableFilterComposer(
            $db: $db,
            $table: $db.trainingDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExerciseTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseTable> {
  $$ExerciseTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscularGroup => $composableBuilder(
    column: $table.muscularGroup,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseTable> {
  $$ExerciseTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get muscularGroup => $composableBuilder(
    column: $table.muscularGroup,
    builder: (column) => column,
  );

  Expression<T> routineDetailRefs<T extends Object>(
    Expression<T> Function($$RoutineDetailTableAnnotationComposer a) f,
  ) {
    final $$RoutineDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineDetail,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.routineDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trainingDetailRefs<T extends Object>(
    Expression<T> Function($$TrainingDetailTableAnnotationComposer a) f,
  ) {
    final $$TrainingDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingDetail,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExerciseTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseTable,
          ExerciseData,
          $$ExerciseTableFilterComposer,
          $$ExerciseTableOrderingComposer,
          $$ExerciseTableAnnotationComposer,
          $$ExerciseTableCreateCompanionBuilder,
          $$ExerciseTableUpdateCompanionBuilder,
          (ExerciseData, $$ExerciseTableReferences),
          ExerciseData,
          PrefetchHooks Function({
            bool routineDetailRefs,
            bool trainingDetailRefs,
          })
        > {
  $$ExerciseTableTableManager(_$AppDatabase db, $ExerciseTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<String> muscularGroup = const Value.absent(),
              }) => ExerciseCompanion(
                id: id,
                exerciseName: exerciseName,
                muscularGroup: muscularGroup,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseName,
                required String muscularGroup,
              }) => ExerciseCompanion.insert(
                id: id,
                exerciseName: exerciseName,
                muscularGroup: muscularGroup,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({routineDetailRefs = false, trainingDetailRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (routineDetailRefs) db.routineDetail,
                    if (trainingDetailRefs) db.trainingDetail,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (routineDetailRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExerciseTable,
                          RoutineDetailData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseTableReferences
                              ._routineDetailRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseTableReferences(
                                db,
                                table,
                                p0,
                              ).routineDetailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (trainingDetailRefs)
                        await $_getPrefetchedData<
                          ExerciseData,
                          $ExerciseTable,
                          TrainingDetailData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseTableReferences
                              ._trainingDetailRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingDetailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExerciseTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseTable,
      ExerciseData,
      $$ExerciseTableFilterComposer,
      $$ExerciseTableOrderingComposer,
      $$ExerciseTableAnnotationComposer,
      $$ExerciseTableCreateCompanionBuilder,
      $$ExerciseTableUpdateCompanionBuilder,
      (ExerciseData, $$ExerciseTableReferences),
      ExerciseData,
      PrefetchHooks Function({bool routineDetailRefs, bool trainingDetailRefs})
    >;
typedef $$RoutineTableCreateCompanionBuilder =
    RoutineCompanion Function({
      Value<int> id,
      required int userId,
      required String routineName,
      required String dayWeek,
      required DateTime creationDate,
    });
typedef $$RoutineTableUpdateCompanionBuilder =
    RoutineCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> routineName,
      Value<String> dayWeek,
      Value<DateTime> creationDate,
    });

final class $$RoutineTableReferences
    extends BaseReferences<_$AppDatabase, $RoutineTable, RoutineData> {
  $$RoutineTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.routine.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserTableTableManager(
      $_db,
      $_db.user,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RoutineDetailTable, List<RoutineDetailData>>
  _routineDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.routineDetail,
    aliasName: $_aliasNameGenerator(db.routine.id, db.routineDetail.routineId),
  );

  $$RoutineDetailTableProcessedTableManager get routineDetailRefs {
    final manager = $$RoutineDetailTableTableManager(
      $_db,
      $_db.routineDetail,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_routineDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrainingTable, List<TrainingData>>
  _trainingRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.training,
    aliasName: $_aliasNameGenerator(db.routine.id, db.training.routineId),
  );

  $$TrainingTableProcessedTableManager get trainingRefs {
    final manager = $$TrainingTableTableManager(
      $_db,
      $_db.training,
    ).filter((f) => f.routineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trainingRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutineTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineTable> {
  $$RoutineTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dayWeek => $composableBuilder(
    column: $table.dayWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableFilterComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> routineDetailRefs(
    Expression<bool> Function($$RoutineDetailTableFilterComposer f) f,
  ) {
    final $$RoutineDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineDetail,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineDetailTableFilterComposer(
            $db: $db,
            $table: $db.routineDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trainingRefs(
    Expression<bool> Function($$TrainingTableFilterComposer f) f,
  ) {
    final $$TrainingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableFilterComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineTable> {
  $$RoutineTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayWeek => $composableBuilder(
    column: $table.dayWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableOrderingComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineTable> {
  $$RoutineTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineName => $composableBuilder(
    column: $table.routineName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dayWeek =>
      $composableBuilder(column: $table.dayWeek, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableAnnotationComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> routineDetailRefs<T extends Object>(
    Expression<T> Function($$RoutineDetailTableAnnotationComposer a) f,
  ) {
    final $$RoutineDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.routineDetail,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.routineDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trainingRefs<T extends Object>(
    Expression<T> Function($$TrainingTableAnnotationComposer a) f,
  ) {
    final $$TrainingTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.routineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableAnnotationComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutineTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineTable,
          RoutineData,
          $$RoutineTableFilterComposer,
          $$RoutineTableOrderingComposer,
          $$RoutineTableAnnotationComposer,
          $$RoutineTableCreateCompanionBuilder,
          $$RoutineTableUpdateCompanionBuilder,
          (RoutineData, $$RoutineTableReferences),
          RoutineData,
          PrefetchHooks Function({
            bool userId,
            bool routineDetailRefs,
            bool trainingRefs,
          })
        > {
  $$RoutineTableTableManager(_$AppDatabase db, $RoutineTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> routineName = const Value.absent(),
                Value<String> dayWeek = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
              }) => RoutineCompanion(
                id: id,
                userId: userId,
                routineName: routineName,
                dayWeek: dayWeek,
                creationDate: creationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String routineName,
                required String dayWeek,
                required DateTime creationDate,
              }) => RoutineCompanion.insert(
                id: id,
                userId: userId,
                routineName: routineName,
                dayWeek: dayWeek,
                creationDate: creationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutineTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                routineDetailRefs = false,
                trainingRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (routineDetailRefs) db.routineDetail,
                    if (trainingRefs) db.training,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$RoutineTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$RoutineTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (routineDetailRefs)
                        await $_getPrefetchedData<
                          RoutineData,
                          $RoutineTable,
                          RoutineDetailData
                        >(
                          currentTable: table,
                          referencedTable: $$RoutineTableReferences
                              ._routineDetailRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutineTableReferences(
                                db,
                                table,
                                p0,
                              ).routineDetailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (trainingRefs)
                        await $_getPrefetchedData<
                          RoutineData,
                          $RoutineTable,
                          TrainingData
                        >(
                          currentTable: table,
                          referencedTable: $$RoutineTableReferences
                              ._trainingRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoutineTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.routineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoutineTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineTable,
      RoutineData,
      $$RoutineTableFilterComposer,
      $$RoutineTableOrderingComposer,
      $$RoutineTableAnnotationComposer,
      $$RoutineTableCreateCompanionBuilder,
      $$RoutineTableUpdateCompanionBuilder,
      (RoutineData, $$RoutineTableReferences),
      RoutineData,
      PrefetchHooks Function({
        bool userId,
        bool routineDetailRefs,
        bool trainingRefs,
      })
    >;
typedef $$RoutineDetailTableCreateCompanionBuilder =
    RoutineDetailCompanion Function({
      Value<int> id,
      required int routineId,
      required int exerciseId,
      required int series,
      required int repetitions,
      required double initialWeight,
    });
typedef $$RoutineDetailTableUpdateCompanionBuilder =
    RoutineDetailCompanion Function({
      Value<int> id,
      Value<int> routineId,
      Value<int> exerciseId,
      Value<int> series,
      Value<int> repetitions,
      Value<double> initialWeight,
    });

final class $$RoutineDetailTableReferences
    extends
        BaseReferences<_$AppDatabase, $RoutineDetailTable, RoutineDetailData> {
  $$RoutineDetailTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RoutineTable _routineIdTable(_$AppDatabase db) =>
      db.routine.createAlias(
        $_aliasNameGenerator(db.routineDetail.routineId, db.routine.id),
      );

  $$RoutineTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutineTableTableManager(
      $_db,
      $_db.routine,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExerciseTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercise.createAlias(
        $_aliasNameGenerator(db.routineDetail.exerciseId, db.exercise.id),
      );

  $$ExerciseTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExerciseTableTableManager(
      $_db,
      $_db.exercise,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoutineDetailTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineDetailTable> {
  $$RoutineDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutineTableFilterComposer get routineId {
    final $$RoutineTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableFilterComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableFilterComposer get exerciseId {
    final $$ExerciseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableFilterComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineDetailTable> {
  $$RoutineDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutineTableOrderingComposer get routineId {
    final $$RoutineTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableOrderingComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableOrderingComposer get exerciseId {
    final $$ExerciseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableOrderingComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineDetailTable> {
  $$RoutineDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<double> get initialWeight => $composableBuilder(
    column: $table.initialWeight,
    builder: (column) => column,
  );

  $$RoutineTableAnnotationComposer get routineId {
    final $$RoutineTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableAnnotationComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableAnnotationComposer get exerciseId {
    final $$ExerciseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableAnnotationComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoutineDetailTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineDetailTable,
          RoutineDetailData,
          $$RoutineDetailTableFilterComposer,
          $$RoutineDetailTableOrderingComposer,
          $$RoutineDetailTableAnnotationComposer,
          $$RoutineDetailTableCreateCompanionBuilder,
          $$RoutineDetailTableUpdateCompanionBuilder,
          (RoutineDetailData, $$RoutineDetailTableReferences),
          RoutineDetailData,
          PrefetchHooks Function({bool routineId, bool exerciseId})
        > {
  $$RoutineDetailTableTableManager(_$AppDatabase db, $RoutineDetailTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> series = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> initialWeight = const Value.absent(),
              }) => RoutineDetailCompanion(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                series: series,
                repetitions: repetitions,
                initialWeight: initialWeight,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routineId,
                required int exerciseId,
                required int series,
                required int repetitions,
                required double initialWeight,
              }) => RoutineDetailCompanion.insert(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                series: series,
                repetitions: repetitions,
                initialWeight: initialWeight,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RoutineDetailTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routineId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routineId,
                                referencedTable: $$RoutineDetailTableReferences
                                    ._routineIdTable(db),
                                referencedColumn: $$RoutineDetailTableReferences
                                    ._routineIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$RoutineDetailTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn: $$RoutineDetailTableReferences
                                    ._exerciseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RoutineDetailTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineDetailTable,
      RoutineDetailData,
      $$RoutineDetailTableFilterComposer,
      $$RoutineDetailTableOrderingComposer,
      $$RoutineDetailTableAnnotationComposer,
      $$RoutineDetailTableCreateCompanionBuilder,
      $$RoutineDetailTableUpdateCompanionBuilder,
      (RoutineDetailData, $$RoutineDetailTableReferences),
      RoutineDetailData,
      PrefetchHooks Function({bool routineId, bool exerciseId})
    >;
typedef $$TrainingTableCreateCompanionBuilder =
    TrainingCompanion Function({
      Value<int> id,
      required int userId,
      required int routineId,
      required DateTime date,
      required int duration,
      required int calories,
    });
typedef $$TrainingTableUpdateCompanionBuilder =
    TrainingCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> routineId,
      Value<DateTime> date,
      Value<int> duration,
      Value<int> calories,
    });

final class $$TrainingTableReferences
    extends BaseReferences<_$AppDatabase, $TrainingTable, TrainingData> {
  $$TrainingTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.training.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserTableTableManager(
      $_db,
      $_db.user,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoutineTable _routineIdTable(_$AppDatabase db) => db.routine
      .createAlias($_aliasNameGenerator(db.training.routineId, db.routine.id));

  $$RoutineTableProcessedTableManager get routineId {
    final $_column = $_itemColumn<int>('routine_id')!;

    final manager = $$RoutineTableTableManager(
      $_db,
      $_db.routine,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TrainingDetailTable, List<TrainingDetailData>>
  _trainingDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trainingDetail,
    aliasName: $_aliasNameGenerator(
      db.training.id,
      db.trainingDetail.trainingId,
    ),
  );

  $$TrainingDetailTableProcessedTableManager get trainingDetailRefs {
    final manager = $$TrainingDetailTableTableManager(
      $_db,
      $_db.trainingDetail,
    ).filter((f) => f.trainingId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trainingDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrainingTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingTable> {
  $$TrainingTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableFilterComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutineTableFilterComposer get routineId {
    final $$RoutineTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableFilterComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> trainingDetailRefs(
    Expression<bool> Function($$TrainingDetailTableFilterComposer f) f,
  ) {
    final $$TrainingDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingDetail,
      getReferencedColumn: (t) => t.trainingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingDetailTableFilterComposer(
            $db: $db,
            $table: $db.trainingDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingTable> {
  $$TrainingTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableOrderingComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutineTableOrderingComposer get routineId {
    final $$RoutineTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableOrderingComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrainingTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingTable> {
  $$TrainingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableAnnotationComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoutineTableAnnotationComposer get routineId {
    final $$RoutineTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routineId,
      referencedTable: $db.routine,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutineTableAnnotationComposer(
            $db: $db,
            $table: $db.routine,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> trainingDetailRefs<T extends Object>(
    Expression<T> Function($$TrainingDetailTableAnnotationComposer a) f,
  ) {
    final $$TrainingDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trainingDetail,
      getReferencedColumn: (t) => t.trainingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.trainingDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrainingTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingTable,
          TrainingData,
          $$TrainingTableFilterComposer,
          $$TrainingTableOrderingComposer,
          $$TrainingTableAnnotationComposer,
          $$TrainingTableCreateCompanionBuilder,
          $$TrainingTableUpdateCompanionBuilder,
          (TrainingData, $$TrainingTableReferences),
          TrainingData,
          PrefetchHooks Function({
            bool userId,
            bool routineId,
            bool trainingDetailRefs,
          })
        > {
  $$TrainingTableTableManager(_$AppDatabase db, $TrainingTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> routineId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<int> calories = const Value.absent(),
              }) => TrainingCompanion(
                id: id,
                userId: userId,
                routineId: routineId,
                date: date,
                duration: duration,
                calories: calories,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int routineId,
                required DateTime date,
                required int duration,
                required int calories,
              }) => TrainingCompanion.insert(
                id: id,
                userId: userId,
                routineId: routineId,
                date: date,
                duration: duration,
                calories: calories,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrainingTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                routineId = false,
                trainingDetailRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trainingDetailRefs) db.trainingDetail,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$TrainingTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$TrainingTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (routineId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.routineId,
                                    referencedTable: $$TrainingTableReferences
                                        ._routineIdTable(db),
                                    referencedColumn: $$TrainingTableReferences
                                        ._routineIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trainingDetailRefs)
                        await $_getPrefetchedData<
                          TrainingData,
                          $TrainingTable,
                          TrainingDetailData
                        >(
                          currentTable: table,
                          referencedTable: $$TrainingTableReferences
                              ._trainingDetailRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TrainingTableReferences(
                                db,
                                table,
                                p0,
                              ).trainingDetailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.trainingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TrainingTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingTable,
      TrainingData,
      $$TrainingTableFilterComposer,
      $$TrainingTableOrderingComposer,
      $$TrainingTableAnnotationComposer,
      $$TrainingTableCreateCompanionBuilder,
      $$TrainingTableUpdateCompanionBuilder,
      (TrainingData, $$TrainingTableReferences),
      TrainingData,
      PrefetchHooks Function({
        bool userId,
        bool routineId,
        bool trainingDetailRefs,
      })
    >;
typedef $$TrainingDetailTableCreateCompanionBuilder =
    TrainingDetailCompanion Function({
      Value<int> id,
      required int trainingId,
      required int exerciseId,
      required int series,
      required int repetitions,
      required double usedWeight,
      required bool completed,
    });
typedef $$TrainingDetailTableUpdateCompanionBuilder =
    TrainingDetailCompanion Function({
      Value<int> id,
      Value<int> trainingId,
      Value<int> exerciseId,
      Value<int> series,
      Value<int> repetitions,
      Value<double> usedWeight,
      Value<bool> completed,
    });

final class $$TrainingDetailTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TrainingDetailTable,
          TrainingDetailData
        > {
  $$TrainingDetailTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TrainingTable _trainingIdTable(_$AppDatabase db) =>
      db.training.createAlias(
        $_aliasNameGenerator(db.trainingDetail.trainingId, db.training.id),
      );

  $$TrainingTableProcessedTableManager get trainingId {
    final $_column = $_itemColumn<int>('training_id')!;

    final manager = $$TrainingTableTableManager(
      $_db,
      $_db.training,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trainingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExerciseTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercise.createAlias(
        $_aliasNameGenerator(db.trainingDetail.exerciseId, db.exercise.id),
      );

  $$ExerciseTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExerciseTableTableManager(
      $_db,
      $_db.exercise,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrainingDetailTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingDetailTable> {
  $$TrainingDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get usedWeight => $composableBuilder(
    column: $table.usedWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  $$TrainingTableFilterComposer get trainingId {
    final $$TrainingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingId,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableFilterComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableFilterComposer get exerciseId {
    final $$ExerciseTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableFilterComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrainingDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingDetailTable> {
  $$TrainingDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get usedWeight => $composableBuilder(
    column: $table.usedWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  $$TrainingTableOrderingComposer get trainingId {
    final $$TrainingTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingId,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableOrderingComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableOrderingComposer get exerciseId {
    final $$ExerciseTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableOrderingComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrainingDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingDetailTable> {
  $$TrainingDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<double> get usedWeight => $composableBuilder(
    column: $table.usedWeight,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  $$TrainingTableAnnotationComposer get trainingId {
    final $$TrainingTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trainingId,
      referencedTable: $db.training,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrainingTableAnnotationComposer(
            $db: $db,
            $table: $db.training,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableAnnotationComposer get exerciseId {
    final $$ExerciseTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercise,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableAnnotationComposer(
            $db: $db,
            $table: $db.exercise,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrainingDetailTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingDetailTable,
          TrainingDetailData,
          $$TrainingDetailTableFilterComposer,
          $$TrainingDetailTableOrderingComposer,
          $$TrainingDetailTableAnnotationComposer,
          $$TrainingDetailTableCreateCompanionBuilder,
          $$TrainingDetailTableUpdateCompanionBuilder,
          (TrainingDetailData, $$TrainingDetailTableReferences),
          TrainingDetailData,
          PrefetchHooks Function({bool trainingId, bool exerciseId})
        > {
  $$TrainingDetailTableTableManager(
    _$AppDatabase db,
    $TrainingDetailTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trainingId = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<int> series = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<double> usedWeight = const Value.absent(),
                Value<bool> completed = const Value.absent(),
              }) => TrainingDetailCompanion(
                id: id,
                trainingId: trainingId,
                exerciseId: exerciseId,
                series: series,
                repetitions: repetitions,
                usedWeight: usedWeight,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trainingId,
                required int exerciseId,
                required int series,
                required int repetitions,
                required double usedWeight,
                required bool completed,
              }) => TrainingDetailCompanion.insert(
                id: id,
                trainingId: trainingId,
                exerciseId: exerciseId,
                series: series,
                repetitions: repetitions,
                usedWeight: usedWeight,
                completed: completed,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrainingDetailTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trainingId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trainingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trainingId,
                                referencedTable: $$TrainingDetailTableReferences
                                    ._trainingIdTable(db),
                                referencedColumn:
                                    $$TrainingDetailTableReferences
                                        ._trainingIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable: $$TrainingDetailTableReferences
                                    ._exerciseIdTable(db),
                                referencedColumn:
                                    $$TrainingDetailTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrainingDetailTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingDetailTable,
      TrainingDetailData,
      $$TrainingDetailTableFilterComposer,
      $$TrainingDetailTableOrderingComposer,
      $$TrainingDetailTableAnnotationComposer,
      $$TrainingDetailTableCreateCompanionBuilder,
      $$TrainingDetailTableUpdateCompanionBuilder,
      (TrainingDetailData, $$TrainingDetailTableReferences),
      TrainingDetailData,
      PrefetchHooks Function({bool trainingId, bool exerciseId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$ExerciseTableTableManager get exercise =>
      $$ExerciseTableTableManager(_db, _db.exercise);
  $$RoutineTableTableManager get routine =>
      $$RoutineTableTableManager(_db, _db.routine);
  $$RoutineDetailTableTableManager get routineDetail =>
      $$RoutineDetailTableTableManager(_db, _db.routineDetail);
  $$TrainingTableTableManager get training =>
      $$TrainingTableTableManager(_db, _db.training);
  $$TrainingDetailTableTableManager get trainingDetail =>
      $$TrainingDetailTableTableManager(_db, _db.trainingDetail);
}
