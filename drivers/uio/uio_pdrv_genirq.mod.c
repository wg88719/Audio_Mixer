#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x95adc399, "module_layout" },
	{ 0x551c52ba, "platform_driver_unregister" },
	{ 0x6860540b, "platform_driver_register" },
	{ 0x10785a91, "malloc_sizes" },
	{ 0xebb18fa5, "dev_set_drvdata" },
	{ 0x876fe5a0, "__uio_register_device" },
	{ 0xc2c27fc9, "pm_runtime_enable" },
	{ 0x8e0f159b, "dev_warn" },
	{ 0x2c4973ba, "platform_get_irq" },
	{ 0x22fdb108, "dev_err" },
	{ 0xfa1d060f, "kmem_cache_alloc" },
	{ 0x27bbf221, "disable_irq_nosync" },
	{ 0x27e1a049, "printk" },
	{ 0x51d559d1, "_raw_spin_unlock_irqrestore" },
	{ 0x3ce4ca6f, "disable_irq" },
	{ 0xca54fee, "_test_and_set_bit" },
	{ 0xfcec0987, "enable_irq" },
	{ 0x2a3aa678, "_test_and_clear_bit" },
	{ 0x598542b2, "_raw_spin_lock_irqsave" },
	{ 0x3a91a846, "__pm_runtime_resume" },
	{ 0x2e5810c6, "__aeabi_unwind_cpp_pr1" },
	{ 0xaa644d87, "__pm_runtime_idle" },
	{ 0x37a0cba, "kfree" },
	{ 0x50609c8c, "__pm_runtime_disable" },
	{ 0x15bc66db, "uio_unregister_device" },
	{ 0x8c4d907a, "dev_get_drvdata" },
	{ 0xefd6cf06, "__aeabi_unwind_cpp_pr0" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

MODULE_ALIAS("of:N*T*Cgeneric-uio*");
