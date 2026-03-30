#import "../lib.typ": collect-render-model, noise-render-spec, render-main-op, timeline-theme

#let doc = json("noise-render.qp101.json")
#let ops = doc.at("operations", default: ())
#let model = collect-render-model(ops)
#let theme = timeline-theme()

#metadata((
  x_error: noise-render-spec(ops.at(0)),
  depolarize1: noise-render-spec(ops.at(2)),
  depolarize2: noise-render-spec(ops.at(4)),
)) <noise-render-spec>

#let single = render-main-op(model.moments.at(0).main.at(0), theme)
#let batched = render-main-op(model.moments.at(2).main.at(0), theme)
#let paired = render-main-op(model.moments.at(4).main.at(0), theme)

#metadata((
  single: (
    count: single.len(),
    qubits: single.map(op => op.first().qubit),
    spans: single.map(op => op.first().n),
    supplement_counts: single.map(op => op.first().supplements.len()),
  ),
  batched: (
    count: batched.len(),
    qubits: batched.map(op => op.first().qubit),
    spans: batched.map(op => op.first().n),
    supplement_counts: batched.map(op => op.first().supplements.len()),
  ),
  paired: (
    count: paired.len(),
    lead_qubit: paired.first().first().qubit,
    span: paired.first().first().n,
    supplement_count: paired.first().first().supplements.len(),
  ),
)) <noise-render-structure>
