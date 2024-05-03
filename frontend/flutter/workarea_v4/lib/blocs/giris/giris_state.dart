import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class GirisState extends Equatable {
  const GirisState();

  @override
  List<Object> get props => [];
}

final class GirisUninitialized extends GirisState {
  const GirisUninitialized();
}

final class GirisYapildi extends GirisState {
  const GirisYapildi();
}

final class GirisYapilmadi extends GirisState {
  const GirisYapilmadi();
}

final class GirisYapiliyor extends GirisState {
  const GirisYapiliyor();
}
