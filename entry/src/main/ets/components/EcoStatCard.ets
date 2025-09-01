@Component
export default struct EcoStatCard {
  @Prop label: string;
  @Prop value: string;
  @Prop unit: string;

  build() {
    Column({ space: 6 }) {
      Text(this.label)
        .fontSize(12)
        .fontColor('#A0AEC0')
        .fontWeight(FontWeight.Medium)

      Text(`${this.value} ${this.unit}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
    }
    .padding(16)
    .backgroundColor('#1E3A5F')
    .borderRadius(16)
    .shadow({ radius: 6, color: '#00000033', offsetX: 0, offsetY: 2 })
  }
}
