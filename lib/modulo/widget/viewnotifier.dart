// import 'dart:convert';
// import 'dart:developer';
// import 'package:aplicacionflutter/model/view_flows_response.dart';
// import 'package:aplicacionflutter/modulo/widget/flowtyper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';

// // ---------- State ----------

// class ViewFlowsState {
//   final List<ViewFlowsResponse> allRows;
//   final List<ViewFlowsResponse> filteredRows;
//   final FlowFilterType selectedFilter;
//   final bool isLoading;

//   const ViewFlowsState({
//     this.allRows = const [],
//     this.filteredRows = const [],
//     this.selectedFilter = FlowFilterType.name,
//     this.isLoading = false,
//   });

//   ViewFlowsState copyWith({
//     List<ViewFlowsResponse>? allRows,
//     List<ViewFlowsResponse>? filteredRows,
//     FlowFilterType? selectedFilter,
//     bool? isLoading,
//   }) {
//     return ViewFlowsState(
//       allRows: allRows ?? this.allRows,
//       filteredRows: filteredRows ?? this.filteredRows,
//       selectedFilter: selectedFilter ?? this.selectedFilter,
//       isLoading: isLoading ?? this.isLoading,
//     );
//   }
// }

// // ---------- Notifier ----------

// class ViewFlowsNotifier extends StateNotifier<ViewFlowsState> {
//   final Ref ref;

//   ViewFlowsNotifier(this.ref) : super(const ViewFlowsState());

//   Future<void> loadFlows(BuildContext context) async {
//     state = state.copyWith(isLoading: true);

//     final service = ref.read(viewFlowsNotifierProvider);
//     final response = await service.a(context, showLoading: false);

//     if (response.result && response.data != null) {
//       log(jsonEncode(response.data));
//       state = state.copyWith(
//         allRows: response.data!,
//         filteredRows: response.data!,
//         isLoading: false,
//       );
//     } else {
//       state = state.copyWith(isLoading: false);
//     }
//   }

//   void changeFilter(FlowFilterType filter) {
//     state = state.copyWith(selectedFilter: filter);
//   }

//   void search(String query) {
//     if (query.isEmpty) {
//       state = state.copyWith(filteredRows: state.allRows);
//       return;
//     }

//     final filtered = state.allRows.where((flow) {
//       final value = _getFieldValue(flow, state.selectedFilter);
//       return value.toLowerCase().contains(query.toLowerCase());
//     }).toList();

//     state = state.copyWith(filteredRows: filtered);
//   }

//   String _getFieldValue(ViewFlowsResponse flow, FlowFilterType filter) {
//     switch (filter) {
//       case FlowFilterType.signingFlowId:
//         return flow.signingFlowId ?? '';
//       case FlowFilterType.signingFlowBaseId:
//         return flow.signingFlowBaseId ?? '';
//       case FlowFilterType.name:
//         return flow.name ?? '';
//       case FlowFilterType.type:
//         return flow.type?.name ?? '';
//       case FlowFilterType.stage:
//         return flow.stage?.name ?? '';
//       case FlowFilterType.involvedFirstName:
//         return flow.involveds?.map((e) => e.user?.firstName ?? '').join(' ') ??
//             '';
//       case FlowFilterType.involvedLastName:
//         return flow.involveds?.map((e) => e.user?.lastName ?? '').join(' ') ??
//             '';
//       case FlowFilterType.involvedEmail:
//         return flow.involveds
//                 ?.map((e) => e.user?.emailAddress ?? '')
//                 .join(' ') ??
//             '';
//       case FlowFilterType.involvedIdentification:
//         return flow.involveds
//                 ?.map((e) => e.user?.identification ?? '')
//                 .join(' ') ??
//             '';
//     }
//   }
// }

// // ---------- Provider ----------

// final viewFlowsNotifierProvider =
//     StateNotifierProvider<ViewFlowsNotifier, ViewFlowsState>(
//       (ref) => ViewFlowsNotifier(ref),
//     );
